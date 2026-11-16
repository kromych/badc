
bool_bitfield_assign_normalizes.x64:	file format elf64-x86-64

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
               	movzbq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	sarq	%rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x7, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	sarq	$0x5, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1d, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	sarq	%rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	xorl	%eax, %eax
               	retq
