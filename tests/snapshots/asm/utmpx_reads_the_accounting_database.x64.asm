
utmpx_reads_the_accounting_database.x64:	file format elf64-x86-64

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
               	subq	$0x188, %rsp            # imm = 0x188
               	pushq	%rbx
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	cmpl	$0x186a0, %ebx          # imm = 0x186A0
               	jge	<addr>
               	movswq	(%rax), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	cmpl	$0x9, %eax
               	jg	<addr>
               	incq	%rbx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	-0x180(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x180, %edx            # imm = 0x180
               	callq	<addr>
               	leaq	-0x180(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	-0x180(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
