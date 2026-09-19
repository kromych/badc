
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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	$0x1, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	movl	$0x3, %r13d
               	movq	%r13, %rdi
               	callq	*%rax
               	movq	%rax, %r12
               	xorl	%edi, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	movq	%r13, %rdi
               	callq	*%rax
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%r12
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
               	popq	%r12
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
               	popq	%r12
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
               	popq	%r12
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
               	popq	%r12
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
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	cmpl	$0x132, %eax            # imm = 0x132
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
