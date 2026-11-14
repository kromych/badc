
dirent_readdir.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	testq	%r13, %r13
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	jmp	<addr>
               	incq	%r12
               	leaq	0x13(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rbx
               	movq	%r13, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	cmpl	$0x2, %r12d
               	jle	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
