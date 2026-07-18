
sysconf_pagesize.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1e, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	-0x1(%rax), %rcx
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	setl	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	setg	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x3c, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x10, %rax
               	jge	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x54, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>
