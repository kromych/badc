
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
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movl	$0x9, (%rax)
               	movl	$0xa, 0x4(%rax)
               	movq	%rax, %rdx
               	andq	$0x1f, %rdx
               	xorl	%ecx, %ecx
               	testl	%edx, %edx
               	jne	<addr>
               	movslq	(%rax), %rdx
               	cmpl	$0x9, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0xa, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leaq	-0x40(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rdx
               	jmp	<addr>

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	movb	$0x1, (%rcx)
               	leaq	0x40(%rsp), %rdx
               	movb	$0x2, (%rdx)
               	leaq	(%rsp), %rsi
               	movb	$0x3, (%rsi)
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdi
               	andq	$0xf, %rdi
               	xorl	%eax, %eax
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
               	movsbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x40(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
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
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movb	$0x1, (%rax)
               	movb	$0x2, 0xfff(%rax)
               	movq	%rax, %rdx
               	andq	$0xfff, %rdx            # imm = 0xFFF
               	xorl	%ecx, %ecx
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	cmpl	$0x1, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0xfff(%rax), %rax
               	cmpl	$0x2, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leaq	-0x1020(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rdx
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
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movb	$0x1, (%rax)
               	leaq	0x1000(%rax), %rdx
               	movb	$0x2, (%rdx)
               	leaq	0x2327(%rax), %rcx
               	movb	$0x3, (%rcx)
               	movq	%rax, %rsi
               	andq	$0x3f, %rsi
               	xorl	%ecx, %ecx
               	testl	%esi, %esi
               	jne	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rdx), %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x2327, %rax           # imm = 0x2327
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leaq	-0x2350(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
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
               	leaq	<rip>, %rdx
               	movq	%rax, (%rdx)
               	movl	$0x1, %esi
               	movw	%si, (%rax)
               	movw	$0x2, 0x7e(%rax)
               	movq	%rax, %rdi
               	andq	$0xf, %rdi
               	xorl	%ecx, %ecx
               	testl	%edi, %edi
               	jne	<addr>
               	movswq	(%rax), %rdi
               	cmpl	$0x1, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movswq	0x7e(%rax), %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rsi, %rax
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rax
               	movq	%rax, (%rdx)
               	movq	$0x7, (%rax)
               	movq	$0x8, 0x18(%rax)
               	testb	$0xf, %al
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0xc0(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	cmpq	$0x8, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testq	%rax, %rax
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
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rdi
               	jmp	<addr>
