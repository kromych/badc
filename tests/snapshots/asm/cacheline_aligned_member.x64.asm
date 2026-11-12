
cacheline_aligned_member.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	leaq	0x40(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	leaq	0x44(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x44, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x40(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	leaq	0x80(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x80, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x40(%rax), %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	cmpl	$0x40, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	0xc0(%rax), %rdx
               	subq	%rax, %rdx
               	cmpl	$0xc0, %edx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	andq	$0x3f, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	testb	$0x3f, %dl
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	addq	$0x40, %rdx
               	testb	$0x3f, %dl
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x80(%rax), %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	addq	$0xc0, %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xb, <rip> # <addr>
               	movl	$0x21, <rip> # <addr>
               	movl	$0x2c, <rip> # <addr>
               	movl	$0x37, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x21, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2c, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x17, %eax
               	retq
