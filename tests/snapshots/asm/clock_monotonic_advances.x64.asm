
clock_monotonic_advances.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400297 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe41(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x10(%rbp), %r11
               	movabsq	$-0x1, %r9
               	movq	%r9, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x8, %r11
               	movq	%r9, (%r11)
               	movl	$0x1, %ebx
               	leaq	-0x10(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400747 <clock_gettime>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	cmpq	$0x0, %r9
               	je	0x40031e <.text+0x9e>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %r9
               	cmpq	$-0x1, %r9
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400370 <.text+0xf0>
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r12
               	addq	$0x8, %r12
               	movq	(%r12), %r9
               	cmpq	$-0x1, %r9
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x400370 <.text+0xf0>
               	movq	-0x48(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x4003a4 <.text+0x124>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %r9
               	cmpq	$0x0, %r9
               	jge	0x4003dc <.text+0x15c>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	movq	%r12, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r12
               	cmpq	$0x0, %r12
               	setl	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x50(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x400436 <.text+0x1b6>
               	leaq	-0x10(%rbp), %r12
               	movq	%r12, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r12
               	cmpq	$0x3b9aca00, %r12       # imm = 0x3B9ACA00
               	setge	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x50(%rbp)
               	jmp	0x400436 <.text+0x1b6>
               	movq	-0x50(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x40046a <.text+0x1ea>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movl	%r9d, -0x28(%rbp)
               	movl	%r9d, -0x30(%rbp)
               	jmp	0x40047a <.text+0x1fa>
               	movslq	-0x30(%rbp), %r9
               	cmpq	$0xf4240, %r9           # imm = 0xF4240
               	jge	0x4004c3 <.text+0x243>
               	jmp	0x4004a9 <.text+0x229>
               	leaq	-0x30(%rbp), %r9
               	movslq	(%r9), %r12
               	movq	%r12, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%r9)
               	jmp	0x40047a <.text+0x1fa>
               	movslq	-0x28(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x28(%rbp)
               	jmp	0x400490 <.text+0x210>
               	movl	$0x1, %r14d
               	leaq	-0x20(%rbp), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400747 <clock_gettime>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	cmpq	$0x0, %r9
               	je	0x400510 <.text+0x290>
               	movl	$0x5, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	movq	(%r12), %r9
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %r14
               	cmpq	%r14, %r9
               	jge	0x40054c <.text+0x2cc>
               	movl	$0x6, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	movq	(%r12), %r14
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %r9
               	cmpq	%r9, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x58(%rbp)
               	cmpq	$0x0, %r12
               	je	0x4005af <.text+0x32f>
               	leaq	-0x20(%rbp), %r9
               	movq	%r9, %r12
               	addq	$0x8, %r12
               	movq	(%r12), %r9
               	leaq	-0x10(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r12
               	cmpq	%r12, %r9
               	setl	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x58(%rbp)
               	jmp	0x4005af <.text+0x32f>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4005e3 <.text+0x363>
               	movl	$0x7, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x40063b <.text+0x3bb>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x4006c2 <.text+0x442>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4006b9 <.text+0x439>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4006bd <.text+0x43d>
               	andb	%ch, 0x74(%rax)
               	je	0x4006cd <.text+0x44d>
               	jae	0x400699 <.text+0x419>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4006d5 <.text+0x455>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x40074d <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x4006fb <.text+0x47b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400782 <exit+0x35>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400779 <exit+0x2c>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40077d <exit+0x30>
               	andb	%ch, 0x74(%rax)
               	je	0x40078d <exit+0x40>
               	jae	0x400759 <exit+0xc>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400795 <exit+0x48>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<clock_gettime>:
               	jmpq	*0xf983(%rip)           # 0x4100d0

<exit>:
               	jmpq	*0xf985(%rip)           # 0x4100d8
