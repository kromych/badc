
popen_reads_command_output.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x40, %esi
               	movq	%rbx, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	callq	<addr>
               	jmp	<addr>
               	decq	%rax
               	movb	$0x0, -0x40(%rbp,%rax)
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x1(%rax), %rdx
               	movsbq	-0x40(%rbp,%rdx), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	cmpl	$0xd, %ecx
               	je	<addr>
               	cmpl	$0x20, %ecx
               	je	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
