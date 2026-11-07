
strtof_and_wcstof_report_range_errors.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	$0x0, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	incq	%rax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movss	0x10(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movss	0x10(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x30, %rax
               	movss	0x10(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x30, %rax
               	movss	0x10(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x48, %rax
               	movss	0x10(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x48, %rax
               	movss	0x10(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x60, %rax
               	movss	0x10(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x60, %rax
               	movss	0x10(%rax), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movsd	0x18(%rsp), %xmm0
               	movq	%rax, %xmm15
               	comiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x800000, %eax         # imm = 0x800000
               	movq	%rax, %xmm15
               	comiss	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x3fd8000000000000, %rax # imm = 0x3FD8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x18(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	fstpt	-0x40(%rbp)
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$-0x3ffc000000000000, %rax # imm = 0xC004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
