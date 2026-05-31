
static_locals.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	movslq	%edi, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	leaq	<rip>, %r9
               	movl	$0x64, %r11d
               	movl	%r11d, (%r9)
               	leaq	<rip>, %r8
               	xorq	%r11, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	leaq	<rip>, %r8
               	movslq	(%r8), %r9
               	movslq	(%r11), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r8)
               	movslq	(%r11), %rdi
               	movslq	(%r8), %r11
               	addq	%r11, %rdi
               	movslq	%edi, %rax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	leaq	<rip>, %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xca, %rax
               	je	<addr>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x131, %rax            # imm = 0x131
               	je	<addr>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xca, %rax
               	je	<addr>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3e9, %rax            # imm = 0x3E9
               	je	<addr>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	je	<addr>
               	movl	$0xa, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
