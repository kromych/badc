
ulimit_reports_the_file_size_limit.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1, %edi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rbx # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x1, %edi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r12
               	cmpq	%rbx, %r12
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	%r12, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x10(%rbp), %rbx
               	shrq	$0x9, %rbx
               	jmp	<addr>
