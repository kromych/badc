
zero_local_aggregate_no_template.x64:	file format elf64-x86-64

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

<seven>:
               	movl	$0x7, %eax
               	retq

<label_template>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, -0x20(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movslq	%edi, %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x14, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	movq	%rbx, (%rsp)
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	leaq	-0x10(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movl	$0x0, 0x8(%rcx)
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	movq	%rax, %rdx
               	movl	$0x9, %eax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	%eax, (%rcx)
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movl	%eax, 0x8(%rcx)
               	movl	%eax, 0xc(%rcx)
               	movl	$0x1, %ecx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	leaq	-0x200(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movups	%xmm14, 0x40(%rcx)
               	movups	%xmm14, 0x50(%rcx)
               	movups	%xmm14, 0x60(%rcx)
               	movups	%xmm14, 0x70(%rcx)
               	movups	%xmm14, 0x80(%rcx)
               	movups	%xmm14, 0x90(%rcx)
               	movups	%xmm14, 0xa0(%rcx)
               	movups	%xmm14, 0xb0(%rcx)
               	movups	%xmm14, 0xc0(%rcx)
               	movups	%xmm14, 0xd0(%rcx)
               	movups	%xmm14, 0xe0(%rcx)
               	movups	%xmm14, 0xf0(%rcx)
               	movups	%xmm14, 0x100(%rcx)
               	movups	%xmm14, 0x110(%rcx)
               	movups	%xmm14, 0x120(%rcx)
               	movups	%xmm14, 0x130(%rcx)
               	movups	%xmm14, 0x140(%rcx)
               	movups	%xmm14, 0x150(%rcx)
               	movups	%xmm14, 0x160(%rcx)
               	movups	%xmm14, 0x170(%rcx)
               	movups	%xmm14, 0x180(%rcx)
               	movups	%xmm14, 0x190(%rcx)
               	movups	%xmm14, 0x1a0(%rcx)
               	movups	%xmm14, 0x1b0(%rcx)
               	movups	%xmm14, 0x1c0(%rcx)
               	movups	%xmm14, 0x1d0(%rcx)
               	movups	%xmm14, 0x1e0(%rcx)
               	movups	%xmm14, 0x1f0(%rcx)
               	jmp	<addr>
               	movslq	%eax, %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movl	$0x1, %ecx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-<rip>, %rcx      # <addr>
               	movq	%rcx, (%rax)
               	xorq	%rbx, %rbx
               	movl	%ebx, 0x8(%rax)
               	callq	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	$0x1, %ebx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
