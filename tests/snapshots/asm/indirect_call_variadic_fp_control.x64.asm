
indirect_call_variadic_fp_control.x64:	file format elf64-x86-64

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

<vsum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movups	%xmm3, -0x70(%rbp,%riz)
               	movups	%xmm4, -0x60(%rbp,%riz)
               	movups	%xmm5, -0x50(%rbp,%riz)
               	movups	%xmm6, -0x40(%rbp,%riz)
               	movups	%xmm7, -0x30(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	movslq	-0xd0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rcx
               	andq	$0x1, %rcx
               	subq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rcx, %xmm1
               	addsd	%xmm1, %xmm0
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xd0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x4, %edi
               	movl	$0x1, %esi
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movl	$0x3, %edx
               	movabsq	$0x4011000000000000, %rcx # imm = 0x4011000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movsd	%xmm0, 0x8(%rsp)
               	movabsq	$0x4025800000000000, %rax # imm = 0x4025800000000000
               	movsd	0x8(%rsp), %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x4, %edi
               	movl	$0x1, %esi
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movl	$0x3, %edx
               	movabsq	$0x4011000000000000, %rcx # imm = 0x4011000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
