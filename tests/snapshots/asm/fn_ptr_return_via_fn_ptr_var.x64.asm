
fn_ptr_return_via_fn_ptr_var.x64:	file format elf64-x86-64

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

<g>:
               	leaq	0x64(%rdi), %rax
               	retq

<h>:
               	leaq	0xc8(%rdi), %rax
               	retq

<f>:
               	testl	%edi, %edi
               	je	<addr>
               	leaq	-<rip>, %rax # <addr>
               	retq
               	leaq	-<rip>, %rax # <addr>
               	jmp	<addr>

<via_param>:
               	pushq	%rax
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
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	xorl	%edi, %edi
               	callq	*%rax
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x1, %edi
               	callq	*%rax
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0x67, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	addq	%r10, %rax
               	cmpl	$0x132, %eax            # imm = 0x132
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
