
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
               	pushq	%rax
               	movl	$0x3, %edi
               	callq	<addr>
               	ud2

<descend>:
               	subq	$0x108, %rsp            # imm = 0x108
               	movb	%dil, (%rsp)
               	testl	%edi, %edi
               	je	<addr>
               	movq	%rdi, %rax
               	subl	$0x1, %eax
               	movb	%al, 0x40(%rsp)
               	je	<addr>
               	subl	$0x1, %eax
               	movb	%al, 0x80(%rsp)
               	je	<addr>
               	subl	$0x1, %eax
               	movb	%al, 0xc0(%rsp)
               	je	<addr>
               	leaq	-0x1(%rax), %rdi
               	callq	<addr>
               	movsbq	0xc0(%rsp), %rcx
               	addq	%rcx, %rax
               	movsbq	0x80(%rsp), %rcx
               	addq	%rcx, %rax
               	movsbq	0x40(%rsp), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x108, %rsp            # imm = 0x108
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
               	pushq	%rax
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
               	popq	%r11
               	retq
