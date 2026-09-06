
init_scalar_conversion.x64:	file format elf64-x86-64

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

<rect_ok>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movsd	(%rcx,%riz), %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rcx,%riz), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsd	0x10(%rcx,%riz), %xmm0
               	movabsq	$0x408a400000000000, %rdx # imm = 0x408A400000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsd	0x18(%rcx,%riz), %xmm0
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x348, %ebx            # imm = 0x348
               	movl	$0x21c, %r12d           # imm = 0x21C
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%r12, %xmm1
               	movsd	%xmm1, 0x8(%rax,%riz)
               	movsd	(%rax,%riz), %xmm2
               	movabsq	$0x408a400000000000, %rcx # imm = 0x408A400000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm2
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x8(%rax,%riz)
               	movsd	%xmm0, 0x10(%rax,%riz)
               	movsd	%xmm1, 0x18(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm2
               	movabsq	$0x408a400000000000, %rcx # imm = 0x408A400000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movsd	0x18(%rax,%riz), %xmm2
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movsd	%xmm0, (%rax,%riz)
               	movsd	%xmm1, 0x8(%rax,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4080e00000000000, %rax # imm = 0x4080E00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movabsq	$0x400f333333333333, %rax # imm = 0x400F333333333333
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x50(%rbp,%riz)
               	movsd	-0x50(%rbp,%riz), %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm14
               	movss	%xmm14, -0x48(%rbp,%riz)
               	leaq	-0x30(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movsd	-0x50(%rbp,%riz), %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rcx,%riz)
               	movss	(%rcx,%riz), %xmm0
               	movss	%xmm0, -0x48(%rbp,%riz)
               	movss	-0x48(%rbp,%riz), %xmm0
               	movl	$0x4078f5c3, %eax       # imm = 0x4078F5C3
               	movq	%rax, %xmm15
               	ucomiss	%xmm0, %xmm15
               	ja	<addr>
               	movss	-0x48(%rbp,%riz), %xmm0
               	movl	$0x407a3d71, %eax       # imm = 0x407A3D71
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x8(%rax,%riz)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rbx, %xmm0
               	movsd	%xmm0, 0x10(%rax,%riz)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r12, %xmm0
               	movsd	%xmm0, 0x18(%rax,%riz)
               	leaq	-0x28(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
