
sysconf_pagesize.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	movl	$0x1e, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	leaq	-0x1(%rax), %rcx
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jl	<addr>
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	jle	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x3c, %edi
               	callq	<addr>
               	cmpq	$0x10, %rax
               	jge	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	$0x54, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
