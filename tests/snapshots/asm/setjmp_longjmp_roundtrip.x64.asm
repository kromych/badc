
setjmp_longjmp_roundtrip.x64:	file format elf64-x86-64

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

<deep>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	testl	%edi, %edi
               	jle	<addr>
               	decq	%rdi
               	popq	%rbp
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0x5, %edi
               	movl	$0x2a, %esi
               	callq	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	ud2
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	ud2
               	movl	$0x7, %esi
               	movl	%esi, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	ud2
