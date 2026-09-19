
fp_const_return.x64:	file format elf64-x86-64

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

<sum_zero>:
               	movl	$0x8, %eax
               	testl	%eax, %eax
               	jle	<addr>
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movq	(%rdi,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movapd	%xmm14, %xmm0
               	retq
               	decq	%rax
               	movslq	%eax, %rax
               	movq	(%rdi,%rax,8), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx,%riz), %xmm0
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rcx
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx,%riz), %xmm0
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rcx
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx,%riz), %xmm0
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rcx
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx,%riz), %xmm0
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rcx
               	xorl	%eax, %eax
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	cmpl	$0x2, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx,%riz), %xmm0
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leave
               	retq
