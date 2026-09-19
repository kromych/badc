
sigsetjmp_roundtrip.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, -0x8(%rbp)
               	movl	$0x7, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
