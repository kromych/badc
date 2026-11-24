
strtof_and_wcstof_report_range_errors.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x48, %rsp
               	movq	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	movq	$0x0, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	incq	%rax
               	addq	$0x48, %rsp
               	retq
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	$0x0, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	$0x0, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	$0x0, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movq	$0x0, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm0
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	xorps	%xmm1, %xmm1
               	comiss	%xmm1, %xmm0
               	jbe	<addr>
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0xa, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rdi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	fstpt	(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rdi
               	leaq	0x28(%rsp), %rsi
               	callq	<addr>
               	fstpt	(%rsp)
               	fldt	(%rsp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
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
