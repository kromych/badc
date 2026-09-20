
overaligned_automatic_boundaries.x64:	file format elf64-x86-64

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

<type32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	movl	$0x9, (%rcx)
               	movl	$0xa, 0x4(%rcx)
               	movq	%rcx, %rdx
               	andq	$0x1f, %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movslq	(%rcx), %rdx
               	cmpl	$0x9, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpl	$0xa, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	-0x40(%rbp), %rsp
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	movb	$0x1, (%rax)
               	leaq	0x40(%rsp), %rdx
               	movb	$0x2, (%rdx)
               	leaq	(%rsp), %rsi
               	movb	$0x3, (%rsi)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, %rdi
               	andq	$0xf, %rdi
               	xorl	%ecx, %ecx
               	testl	%edi, %edi
               	jne	<addr>
               	andq	$0x1f, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rsi, %rdx
               	andq	$0x3f, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	0x40(%rsp), %rax
               	cmpl	$0x2, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rsp), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>

<at_page>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x20, %rsp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	movq	$0x0, (%rsp)
               	andq	$-0x1000, %rsp          # imm = 0xF000
               	movq	$0x0, (%rsp)
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	movb	$0x1, (%rcx)
               	movb	$0x2, 0xfff(%rcx)
               	movq	%rcx, %rdx
               	andq	$0xfff, %rdx            # imm = 0xFFF
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	(%rcx), %rdx
               	cmpl	$0x1, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0xfff(%rcx), %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	-0x1020(%rbp), %rsp
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>

<over_a_page>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x350, %rsp            # imm = 0x350
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x340, %rsp            # imm = 0x340
               	movq	$0x0, (%rsp)
               	andq	$-0x40, %rsp
               	movq	$0x0, (%rsp)
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	movb	$0x1, (%rcx)
               	leaq	0x1000(%rcx), %rdx
               	movb	$0x2, (%rdx)
               	leaq	0x2327(%rcx), %rax
               	movb	$0x3, (%rax)
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	xorl	%eax, %eax
               	testl	%esi, %esi
               	jne	<addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x2327, %rax           # imm = 0x2327
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	-0x2350(%rbp), %rsp
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movw	$0x4, (%rax)
               	movq	%rax, %rcx
               	andq	$0x1f, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	leaq	-0x140(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movl	$0x1, %edx
               	movw	%dx, (%rax)
               	movl	$0x2, %esi
               	movw	%si, 0x7e(%rax)
               	testb	$0xf, %al
               	jne	<addr>
               	movswq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movq	%rax, (%rcx)
               	movq	$0x7, (%rax)
               	movq	$0x8, 0x18(%rax)
               	testb	$0xf, %al
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	%rsi, %rax
               	leave
               	retq
               	movq	%rdx, %rax
               	leave
               	retq
