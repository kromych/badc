
basename_dirname_split.x64:	file format elf64-x86-64

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

<splits_to>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %rbx
               	movq	%rdx, %r12
               	leaq	-0x40(%rbp), %rax
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	callq	*%rbx
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movb	$0x0, (%rax)
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	shlq	%rax
               	incq	%rax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	shlq	%rax
               	addq	$0x2, %rax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x64, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
