
function_macro.x64:	file format elf64-x86-64

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
               	cmpl	%r9d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	incq	%rsi
               	incq	%rdi
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rsi), %r8
               	xorq	%rsi, %rsi
               	testq	%r8, %r8
               	jne	<addr>
               	movsbq	(%rdi), %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x15, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
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
               	movl	$0x1f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
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
               	movl	$0x29, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rsi
               	movsbq	(%rsi), %r8
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rsi), %r8
               	movsbq	(%rdi), %r9
               	cmpl	%r9d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	incq	%rsi
               	incq	%rdi
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rsi), %r8
               	xorq	%rsi, %rsi
               	testq	%r8, %r8
               	jne	<addr>
               	movsbq	(%rdi), %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rdx, %rsi
               	movsbq	(%rsi), %r8
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rsi), %r8
               	movsbq	(%rdi), %r9
               	cmpl	%r9d, %r8d
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	incq	%rsi
               	incq	%rdi
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rsi), %r8
               	xorq	%rsi, %rsi
               	testq	%r8, %r8
               	jne	<addr>
               	movsbq	(%rdi), %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movq	%rax, %rsi
               	movsbq	(%rsi), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	(%rsi), %rdi
               	movsbq	(%rcx), %r8
               	cmpl	%r8d, %edi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	incq	%rsi
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rsi), %rdi
               	xorq	%rsi, %rsi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movsbq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movsbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rax), %rcx
               	movsbq	(%rdx), %rsi
               	cmpl	%esi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rax
               	incq	%rdx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	(%rdx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
