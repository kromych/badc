
function_macro.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rsi, %rcx
               	movsbq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rcx
               	incq	%rax
               	movsbq	(%rcx), %rdx
               	nopw	(%rax,%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpb	$0x0, (%rcx)
               	jne	<addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x15, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	nopl	(%rax,%rax)
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
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
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
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
               	leaq	<rip>, %rax # <addr>
               	movq	%r8, %rcx
               	movsbq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rcx
               	incq	%rax
               	movsbq	(%rcx), %rdx
               	nopl	(%rax,%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpb	$0x0, (%rcx)
               	jne	<addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%r9, %rcx
               	movsbq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rcx
               	incq	%rax
               	movsbq	(%rcx), %rdx
               	nop
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpb	$0x0, (%rcx)
               	jne	<addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movq	%rsi, %rax
               	movsbq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%r8), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	incq	%r8
               	movsbq	(%rax), %rcx
               	nopw	(%rax,%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	cmpb	$0x0, (%r8)
               	je	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movsbq	(%r9), %rcx
               	nop
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%rsi
               	incq	%r9
               	movsbq	(%rsi), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpb	$0x0, (%rsi)
               	jne	<addr>
               	cmpb	$0x0, (%r9)
               	je	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
