
exit_from_nested_call.x64:	file format elf64-x86-64

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

<handler>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	callq	<addr>
               	ud2

<descend>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movb	%dil, -0x100(%rbp)
               	testl	%edi, %edi
               	je	<addr>
               	movq	%rdi, %rax
               	subl	$0x1, %eax
               	movb	%al, -0xc0(%rbp)
               	je	<addr>
               	subl	$0x1, %eax
               	movb	%al, -0x80(%rbp)
               	je	<addr>
               	subl	$0x1, %eax
               	movb	%al, -0x40(%rbp)
               	je	<addr>
               	leaq	-0x1(%rax), %rdi
               	callq	<addr>
               	movsbq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0xc0(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x100(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	ud2
               	movl	$0x2, %edi
               	callq	<addr>
               	ud2
               	movl	$0x2, %edi
               	callq	<addr>
               	ud2
               	movl	$0x2, %edi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	callq	<addr>
               	movl	$0x8, %edi
               	callq	<addr>
               	movl	$0x4, %ecx
               	movl	$0x5, %edx
               	testl	%eax, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
