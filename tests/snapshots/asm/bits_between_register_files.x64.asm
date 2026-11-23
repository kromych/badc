
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x178, %rsp            # imm = 0x178
               	pushq	%rbx
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0xf8(%rbp)
               	movsd	-0xf8(%rbp), %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	leaq	-0x158(%rbp), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x150(%rbp), %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x130(%rbp), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	-0x130(%rbp,%rax), %rsi
               	movsbq	-0x158(%rbp,%rax), %rcx
               	movsbq	-0x150(%rbp,%rax), %rdx
               	leaq	(%rcx,%rdx), %rdi
               	movsbq	%dil, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	-0x130(%rbp), %rsi
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
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
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
               	movsd	%xmm0, -0xf0(%rbp)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x100(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, -0xe8(%rbp)
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xe8(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x100(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x3fffffffffffffff, %rdi # imm = 0xC000000000000001
               	callq	<addr>
               	movsd	%xmm0, -0xe0(%rbp)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x100(%rbp), %rax
               	movabsq	$-0x3fffffffffffffff, %r11 # imm = 0xC000000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x148(%rbp), %rdi
               	movabsq	$0x7ff8000000000123, %rsi # imm = 0x7FF8000000000123
               	callq	<addr>
               	movsd	-0x148(%rbp), %xmm0
               	movsd	%xmm0, -0xd8(%rbp)
               	leaq	-0x100(%rbp), %rax
               	leaq	-0xd8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x100(%rbp), %rax
               	movabsq	$0x7ff8000000000123, %r11 # imm = 0x7FF8000000000123
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x140(%rbp), %rdi
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movq	-0x140(%rbp), %rax
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, -0xd0(%rbp)
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x100(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, -0xc8(%rbp)
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0xc8(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x100(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x120(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x20(%rcx), %r10
               	movq	%r10, 0x20(%rax)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, -0xc0(%rbp)
               	leaq	-0x138(%rbp), %rax
               	leaq	-0xc0(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movsd	%xmm0, -0xb8(%rbp)
               	leaq	-0xb8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, %xmm0
               	movsd	-0x120(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0xb0(%rbp)
               	leaq	-0xb0(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, -0xa8(%rbp)
               	leaq	-0xa8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movq	%xmm0, %rcx
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	xorq	%r11, %rcx
               	movq	%rcx, -0xa0(%rbp)
               	leaq	-0xa0(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movsd	%xmm0, -0x98(%rbp)
               	leaq	-0x98(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rax
               	movq	%rax, %xmm0
               	movsd	-0x118(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x90(%rbp)
               	leaq	-0x138(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movq	%xmm0, %rcx
               	movabsq	$0x20000000000, %r11    # imm = 0x20000000000
               	xorq	%r11, %rcx
               	movq	%rcx, -0x80(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movsd	%xmm0, -0x78(%rbp)
               	leaq	-0x78(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, %xmm0
               	movsd	-0x110(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x30000000000, %r11    # imm = 0x30000000000
               	xorq	%r11, %rax
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x138(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movsd	%xmm0, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, %xmm0
               	leaq	-0x120(%rbp), %rdi
               	movsd	-0x108(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movq	%xmm0, %rcx
               	movabsq	$0x40000000000, %r11    # imm = 0x40000000000
               	xorq	%r11, %rcx
               	movq	%rcx, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm0
               	movsd	%xmm0, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movq	%rcx, %xmm0
               	movsd	-0x100(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x138(%rbp), %rax
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x138(%rbp), %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movl	$0x5, %esi
               	callq	<addr>
               	movsd	%xmm0, -0x20(%rbp)
               	leaq	-0x138(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rcx
               	movsd	0x10(%rsp), %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	leaq	-0x138(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x138(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x7fffffffffffffff, %rdi # imm = 0x8000000000000001
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x138(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x138(%rbp), %rax
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	cmpl	$0xbfc00000, %eax       # imm = 0xBFC00000
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
