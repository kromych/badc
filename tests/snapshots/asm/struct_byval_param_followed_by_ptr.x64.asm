
struct_byval_param_followed_by_ptr.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x1e, %edx
               	testl	%edx, %edx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	<rip>, %ecx # <addr>
               	movq	%rdx, 0x8(%rsp)
               	movq	%rdx, %rsi
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x8(%rsp), %rdx
               	movq	%rdx, %rax
               	addq	$0x18, %rsp
               	retq
               	cmpl	$0x1, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %ecx
               	movq	%rax, %rdx
               	movq	%rcx, %rax
               	jmp	<addr>
