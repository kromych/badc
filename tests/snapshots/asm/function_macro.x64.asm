
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

<helper_one>:
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	cmpb	$0x0, (%rsi)
               	je	<addr>
               	movsbq	(%rsi), %r8
               	movsbq	(%rdi), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rsi
               	incq	%rdi
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	movsbq	(%rsi), %r8
               	xorl	%esi, %esi
               	testl	%r8d, %r8d
               	jne	<addr>
               	movsbq	(%rdi), %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rdi
               	movq	%rcx, %rsi
               	cmpb	$0x0, (%rsi)
               	je	<addr>
               	movsbq	(%rsi), %r8
               	movsbq	(%rdi), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rsi
               	incq	%rdi
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	movsbq	(%rsi), %r8
               	xorl	%esi, %esi
               	testl	%r8d, %r8d
               	jne	<addr>
               	movsbq	(%rdi), %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rdi
               	movq	%rdx, %rsi
               	cmpb	$0x0, (%rsi)
               	je	<addr>
               	movsbq	(%rsi), %r8
               	movsbq	(%rdi), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	incq	%rsi
               	incq	%rdi
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	movsbq	(%rsi), %r8
               	xorl	%esi, %esi
               	testl	%r8d, %r8d
               	jne	<addr>
               	movsbq	(%rdi), %rsi
               	testl	%esi, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rax, %rsi
               	cmpb	$0x0, (%rsi)
               	je	<addr>
               	movsbq	(%rsi), %rdi
               	movsbq	(%rcx), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	incq	%rsi
               	incq	%rcx
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	movsbq	(%rsi), %rdi
               	xorl	%esi, %esi
               	testl	%edi, %edi
               	jne	<addr>
               	movsbq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x18, %eax
               	retq
               	movsbq	(%rax), %rcx
               	movsbq	(%rdx), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	incq	%rdx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	movsbq	(%rdx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x19, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1f, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x29, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
