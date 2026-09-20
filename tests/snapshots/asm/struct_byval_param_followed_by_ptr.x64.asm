
struct_byval_param_followed_by_ptr.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movl	%ebx, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x1e, %ebx
               	testl	%ebx, %ebx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x8(%rbp), %rdx
               	movslq	(%rax), %rcx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x8(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, -0x8(%rbp)
               	jmp	<addr>
