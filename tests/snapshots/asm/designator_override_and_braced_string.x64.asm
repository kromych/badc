
designator_override_and_braced_string.x64:	file format elf64-x86-64

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

<take>:
               	movsbq	(%rdi), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movsbq	0x1(%rdi), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movsbq	0x2(%rdi), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	cmpb	$0x0, 0x3(%rdi)
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsbq	0xc(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movsbq	0xd(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0xe(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x5(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rcx), %r10
               	movw	%r10w, 0x4(%rax)
               	xorl	%eax, %eax
               	leave
               	retq
