
overaligned_automatic_boundaries.x64:	file format elf64-x86-64

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

<type32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0xa00000009, %rax      # imm = 0xA00000009
               	movq	%rax, (%rsp)
               	andq	$0x1f, %rcx
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	cmovneq	%rax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	0x4(%rsp), %eax
               	cmpl	$0xa, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	movb	$0x1, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movb	$0x2, 0x40(%rsp)
               	leaq	(%rsp), %rsi
               	movb	$0x3, (%rsp)
               	movq	%rcx, <rip> # <addr>
               	andq	$0xf, %rcx
               	xorl	%eax, %eax
               	andq	$0x1f, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%ecx, %ecx
               	cmovneq	%rax, %rdx
               	andq	$0x3f, %rsi
               	testl	%esi, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	cmoveq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x60(%rsp), %rcx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x40(%rsp), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rsp), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<at_page>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	movq	$0x0, (%rsp)
               	andq	$-0x1000, %rsp          # imm = 0xF000
               	movq	$0x0, (%rsp)
               	leaq	(%rsp), %rcx
               	movq	%rcx, <rip> # <addr>
               	movb	$0x1, (%rsp)
               	movb	$0x2, 0xfff(%rsp)
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	cmovneq	%rax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0xfff(%rsp), %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<over_a_page>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x340, %rsp            # imm = 0x340
               	movq	$0x0, (%rsp)
               	andq	$-0x40, %rsp
               	movq	$0x0, (%rsp)
               	leaq	(%rsp), %rcx
               	movq	%rcx, <rip> # <addr>
               	movb	$0x1, (%rsp)
               	leaq	0x1000(%rcx), %rdx
               	movb	$0x2, (%rdx)
               	leaq	0x2327(%rcx), %rsi
               	movb	$0x3, (%rsi)
               	andq	$0x3f, %rcx
               	xorl	%eax, %eax
               	movl	$0x1, %edi
               	testl	%ecx, %ecx
               	cmovneq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	(%rdx), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rsi), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movw	$0x4, (%rsp)
               	andq	$0x1f, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	testl	%eax, %eax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	leave
               	retq

<main>:
               	subq	$0xa8, %rsp
               	leaq	(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1, %ecx
               	movw	%cx, (%rsp)
               	movl	$0x2, %edx
               	movw	%dx, 0x7e(%rsp)
               	testb	$0xf, %al
               	jne	<addr>
               	leaq	0x80(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x7, 0x80(%rsp)
               	movq	$0x8, 0x98(%rsp)
               	testb	$0xf, %al
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0xa8, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0xa8, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0xa8, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0xa8, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0xa8, %rsp
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0xa8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xa8, %rsp
               	retq
               	movq	%rdx, %rax
               	addq	$0xa8, %rsp
               	retq
               	movq	%rcx, %rax
               	addq	$0xa8, %rsp
               	retq
