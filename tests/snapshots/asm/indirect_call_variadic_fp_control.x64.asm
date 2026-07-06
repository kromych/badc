
indirect_call_variadic_fp_control.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<vsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	jmp	<addr>
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	andq	$0x1, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsd	-0x20(%rbp,%riz), %xmm0
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movslq	(%rdx), %rdx
               	cvtsi2sd	%rdx, %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	jmp	<addr>
               	movsd	-0x20(%rbp,%riz), %xmm0
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movsd	(%rdx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	movslq	-0xe0(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsd	-0x20(%rbp,%riz), %xmm0
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-<rip>, %rax      # <addr>
               	movl	$0x4, %edi
               	movl	$0x1, %esi
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movl	$0x3, %ecx
               	movabsq	$0x4011000000000000, %r8 # imm = 0x4011000000000000
               	movq	%rax, %r9
               	movq	%rdx, %xmm0
               	movq	%r8, %xmm1
               	movq	%rcx, %rdx
               	movb	$0x2, %al
               	callq	*%r9
               	movsd	%xmm0, 0x8(%rsp)
               	movabsq	$0x4025800000000000, %rax # imm = 0x4025800000000000
               	movsd	0x8(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x1, %esi
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movl	$0x3, %ecx
               	movabsq	$0x4011000000000000, %r8 # imm = 0x4011000000000000
               	movq	%rdx, %xmm0
               	movq	%r8, %xmm1
               	movq	%rcx, %rdx
               	movb	$0x2, %al
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
