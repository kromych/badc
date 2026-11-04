
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
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rdi # <addr>
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
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x15, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
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
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x1f, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
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
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x29, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
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
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
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
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
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
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movsbq	(%rax), %rcx
               	movsbq	(%rdx), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	incq	%rdx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	cmpb	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
