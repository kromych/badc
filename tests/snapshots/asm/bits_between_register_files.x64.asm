
bits_between_register_files.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rdi, %rcx
               	movsd	(%rcx), %xmm1
               	addsd	%xmm1, %xmm0
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
               	subq	$0x90, %rsp
               	movabsq	$-0x3f6cb5c000000000, %rax # imm = 0xC0934A4000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	leaq	-0x70(%rbp), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x68(%rbp), %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x48(%rbp), %rdi
               	movq	%rdi, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	movsbq	(%rdi,%rax), %rsi
               	leaq	-0x70(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	leaq	-0x68(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	leaq	(%rcx,%rdx), %r8
               	movsbq	%r8b, %r8
               	cmpl	%r8d, %esi
               	jne	<addr>
               	leaq	-0x48(%rbp), %rsi
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
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movabsq	$-0x3fffffffffffffff, %rdi # imm = 0xC000000000000001
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rax
               	movabsq	$-0x3fffffffffffffff, %r11 # imm = 0xC000000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdi
               	movabsq	$0x7ff8000000000123, %rsi # imm = 0x7FF8000000000123
               	callq	<addr>
               	movsd	-0x60(%rbp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rax
               	movabsq	$0x7ff8000000000123, %r11 # imm = 0x7FF8000000000123
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movq	-0x58(%rbp), %rax
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x20(%rsi), %r10
               	movq	%r10, 0x20(%rax)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, -0x8(%rbp)
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x50(%rbp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rcx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x50(%rbp), %xmm0
               	movq	%xmm0, %rdx
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	xorq	%r11, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x50(%rbp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rcx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x50(%rbp), %xmm0
               	movq	%xmm0, %rdx
               	movabsq	$0x20000000000, %r11    # imm = 0x20000000000
               	xorq	%r11, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movsd	-0x50(%rbp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x50(%rbp), %xmm0
               	movq	%xmm0, %rdx
               	movabsq	$0x30000000000, %r11    # imm = 0x30000000000
               	xorq	%r11, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x50(%rbp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, %xmm0
               	movsd	-0x20(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x50(%rbp), %xmm0
               	movq	%xmm0, %rdx
               	movabsq	$0x40000000000, %r11    # imm = 0x40000000000
               	xorq	%r11, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x50(%rbp), %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, %xmm0
               	leaq	-0x38(%rbp), %rdi
               	movsd	-0x18(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movsd	-0x50(%rbp), %xmm14
               	movsd	%xmm14, 0x10(%rsp)
               	movl	$0x5, %esi
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rdx
               	movsd	0x10(%rsp), %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	-0x50(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movabsq	$-0x7fffffffffffffff, %rdi # imm = 0x8000000000000001
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	-0x50(%rbp), %rax
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0xbfc00000, %eax       # imm = 0xBFC00000
               	movq	%rax, %xmm0
               	callq	<addr>
               	cmpl	$0xbfc00000, %eax       # imm = 0xBFC00000
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
