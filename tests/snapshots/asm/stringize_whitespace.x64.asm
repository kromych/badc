
stringize_whitespace.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movsbq	(%rcx), %rsi
               	xorq	%rax, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	movsbq	(%rdx), %rsi
               	cmpl	%esi, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%rcx
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rcx), %rax
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	(%rdx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movsbq	(%rax), %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
