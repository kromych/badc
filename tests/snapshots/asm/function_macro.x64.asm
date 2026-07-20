
function_macro.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<helper_one>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	movsbq	(%rsi), %r8
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rsi), %r8
               	movsbq	(%rdi), %r9
               	cmpq	%r9, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	incq	%rsi
               	incq	%rdi
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	xorq	%rsi, %rsi
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rdi), %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rdi
               	movq	%rcx, %rsi
               	movsbq	(%rsi), %r8
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rsi), %r8
               	movsbq	(%rdi), %r9
               	cmpq	%r9, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	incq	%rsi
               	incq	%rdi
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	xorq	%rsi, %rsi
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rdi), %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rdi
               	movq	%rdx, %rsi
               	movsbq	(%rsi), %r8
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rsi), %r8
               	movsbq	(%rdi), %r9
               	cmpq	%r9, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	incq	%rsi
               	incq	%rdi
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	xorq	%rsi, %rsi
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rdi), %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rax, %rsi
               	movsbq	(%rsi), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	(%rsi), %rdi
               	movsbq	(%rcx), %r8
               	cmpq	%r8, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	incq	%rsi
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	sete	%dil
               	movzbq	%dil, %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x18, %eax
               	retq
               	movsbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rax), %rcx
               	movsbq	(%rdx), %rsi
               	cmpq	%rsi, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<helper_two>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1f, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x29, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
