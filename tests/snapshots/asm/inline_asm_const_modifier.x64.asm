
inline_asm_const_modifier.x64:	file format elf64-x86-64

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

<get_seven>:
               	movl	$0x7, %eax
               	retq

<read_directive_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movl	(%rax), %ebx
               	movl	%ebx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	popq	%rbx
               	leave
               	retq

<address_modifier>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	retq

<call_modifier>:
               	callq	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movl	(%rax), %ebx
               	movl	%ebx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
