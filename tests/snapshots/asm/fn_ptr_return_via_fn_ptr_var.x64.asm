
fn_ptr_return_via_fn_ptr_var.x64:	file format elf64-x86-64

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

<g>:
               	leaq	0x64(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<h>:
               	leaq	0xc8(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<f>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	jmp	<addr>

<via_param>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	$0x1, %edi
               	callq	*%rbx
               	movl	$0x3, %edi
               	callq	*%rax
               	movq	%rax, %r12
               	xorl	%edi, %edi
               	callq	*%rbx
               	movl	$0x3, %edi
               	callq	*%rax
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpl	$0x132, %eax            # imm = 0x132
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
