
bits_between_register_files.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<pair>:
               	movsd	(%rsi), %xmm0
               	movsd	(%rdx), %xmm1
               	vpaddb	%xmm1, %xmm0, %xmm2
               	vpsubb	%xmm1, %xmm0, %xmm0
               	movsd	%xmm2, (%rdi)
               	movsd	%xmm0, 0x8(%rdi)
               	retq

<flip>:
               	movq	%xmm0, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	xorq	%r11, %rax
               	movq	%rax, %xmm0
               	retq

<bits>:
               	movq	%xmm0, %rax
               	retq

<from>:
               	movq	%rdi, %xmm0
               	retq

<store_from>:
               	movq	%rsi, (%rdi)
               	retq

<store_bits>:
               	movsd	%xmm0, (%rdi)
               	retq

<cast_bits>:
               	movq	%xmm0, %rax
               	retq

<mix>:
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x28, %rdx
               	xorq	%rcx, %rdx
               	movq	%rdx, %xmm0
               	vaddsd	(%rdi,%rax,8), %xmm0, %xmm0
               	movq	%xmm0, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %xmm0
               	retq

<copy_bits>:
               	movq	%xmm0, %rax
               	retq

<copy_from>:
               	movq	%rdi, %xmm0
               	retq

<copy_float_bits>:
               	subq	$0x18, %rsp
               	movss	%xmm0, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x180, %rsp            # imm = 0x180
               	pushq	%rbx
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x88(%rsp)
               	movsd	0x88(%rsp), %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	leaq	0x28(%rsp), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	0x30(%rsp), %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	0x50(%rsp), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	0x50(%rsp,%rax), %rsi
               	movsbq	0x28(%rsp,%rax), %rcx
               	movsbq	0x30(%rsp,%rax), %rdx
               	leaq	(%rcx,%rdx), %rdi
               	movsbq	%dil, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	0x50(%rsp), %rsi
               	addq	$0x8, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	subq	%rdx, %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm1
               	vxorpd	<rip>, %xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movapd	%xmm0, %xmm1
               	xorps	%xmm0, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	callq	<addr>
               	movsd	%xmm0, 0x90(%rsp)
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x80(%rsp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, 0x98(%rsp)
               	leaq	0x80(%rsp), %rcx
               	leaq	0x98(%rsp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	0x80(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	movabsq	$-0x3fffffffffffffff, %rdi # imm = 0xC000000000000001
               	callq	<addr>
               	movsd	%xmm0, 0xa0(%rsp)
               	leaq	0x80(%rsp), %rax
               	leaq	0xa0(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x80(%rsp), %rax
               	movabsq	$-0x3fffffffffffffff, %r11 # imm = 0xC000000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	leaq	0x38(%rsp), %rdi
               	movabsq	$0x7ff8000000000123, %rsi # imm = 0x7FF8000000000123
               	callq	<addr>
               	movsd	0x38(%rsp), %xmm0
               	movsd	%xmm0, 0xa8(%rsp)
               	leaq	0x80(%rsp), %rax
               	leaq	0xa8(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x80(%rsp), %rax
               	movabsq	$0x7ff8000000000123, %r11 # imm = 0x7FF8000000000123
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	leaq	0x40(%rsp), %rdi
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movq	0x40(%rsp), %rax
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, 0xb0(%rsp)
               	leaq	0x80(%rsp), %rcx
               	leaq	0xb0(%rsp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	0x80(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, 0xb8(%rsp)
               	leaq	0x80(%rsp), %rcx
               	leaq	0xb8(%rsp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	0x80(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	leaq	0x60(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x20(%rcx), %r10
               	movq	%r10, 0x20(%rax)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, 0xc0(%rsp)
               	leaq	0x48(%rsp), %rax
               	leaq	0xc0(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movsd	%xmm0, 0xc8(%rsp)
               	leaq	0xc8(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movq	%rcx, %xmm0
               	movsd	0x60(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0xd0(%rsp)
               	leaq	0xd0(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movq	%rcx, 0xd8(%rsp)
               	leaq	0xd8(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	xorq	%r11, %rcx
               	movq	%rcx, 0xe0(%rsp)
               	leaq	0xe0(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movsd	%xmm0, 0xe8(%rsp)
               	leaq	0xe8(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rax
               	movq	%rax, %xmm0
               	movsd	0x68(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0xf0(%rsp)
               	leaq	0x48(%rsp), %rax
               	leaq	0xf0(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movq	%rcx, 0xf8(%rsp)
               	leaq	0xf8(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	movabsq	$0x20000000000, %r11    # imm = 0x20000000000
               	xorq	%r11, %rcx
               	movq	%rcx, 0x100(%rsp)
               	leaq	0x100(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movsd	%xmm0, 0x108(%rsp)
               	leaq	0x108(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movq	%rcx, %xmm0
               	movsd	0x70(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x110(%rsp)
               	leaq	0x110(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movq	%rcx, 0x118(%rsp)
               	leaq	0x118(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x30000000000, %r11    # imm = 0x30000000000
               	xorq	%r11, %rax
               	movq	%rax, 0x120(%rsp)
               	leaq	0x48(%rsp), %rax
               	leaq	0x120(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movsd	%xmm0, 0x128(%rsp)
               	leaq	0x128(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movq	%rcx, %xmm0
               	leaq	0x60(%rsp), %rdi
               	movsd	0x78(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x130(%rsp)
               	leaq	0x130(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movq	%rcx, 0x138(%rsp)
               	leaq	0x138(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movq	%xmm0, %rcx
               	movabsq	$0x40000000000, %r11    # imm = 0x40000000000
               	xorq	%r11, %rcx
               	movq	%rcx, 0x140(%rsp)
               	leaq	0x140(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm0
               	movsd	%xmm0, 0x148(%rsp)
               	leaq	0x148(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movq	%rcx, %xmm0
               	movsd	0x80(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x150(%rsp)
               	leaq	0x150(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rax
               	movq	%rax, 0x158(%rsp)
               	leaq	0x48(%rsp), %rax
               	leaq	0x158(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	0x48(%rsp), %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movl	$0x5, %esi
               	callq	<addr>
               	movsd	%xmm0, 0x160(%rsp)
               	leaq	0x48(%rsp), %rax
               	leaq	0x160(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rcx
               	movsd	0x10(%rsp), %xmm14
               	movsd	%xmm14, 0x168(%rsp)
               	leaq	0x168(%rsp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, 0x170(%rsp)
               	leaq	0x48(%rsp), %rcx
               	leaq	0x170(%rsp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	0x48(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	movabsq	$-0x7fffffffffffffff, %rdi # imm = 0x8000000000000001
               	callq	<addr>
               	movsd	%xmm0, 0x178(%rsp)
               	leaq	0x48(%rsp), %rax
               	leaq	0x178(%rsp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	0x48(%rsp), %rax
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	cmpl	$0xbfc00000, %eax       # imm = 0xBFC00000
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x180, %rsp            # imm = 0x180
               	retq
