
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
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movslq	%edi, %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x220, %rsp            # imm = 0x220
               	movq	%rbx, (%rsp)
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movl	%edx, 0x8(%rax)
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rdx), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	movq	%rcx, %rdx
               	movl	$0x9, %edx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	movslq	%edx, %rdx
               	cmpq	$0x9, %rdx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movslq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rdx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rcx), %rax
               	movq	%rax, 0x18(%rdx)
               	movq	0x20(%rcx), %rax
               	movq	%rax, 0x20(%rdx)
               	movq	0x28(%rcx), %rax
               	movq	%rax, 0x28(%rdx)
               	movq	0x30(%rcx), %rax
               	movq	%rax, 0x30(%rdx)
               	movq	0x38(%rcx), %rax
               	movq	%rax, 0x38(%rdx)
               	movq	0x40(%rcx), %rax
               	movq	%rax, 0x40(%rdx)
               	movq	0x48(%rcx), %rax
               	movq	%rax, 0x48(%rdx)
               	movq	0x50(%rcx), %rax
               	movq	%rax, 0x50(%rdx)
               	movq	0x58(%rcx), %rax
               	movq	%rax, 0x58(%rdx)
               	movq	0x60(%rcx), %rax
               	movq	%rax, 0x60(%rdx)
               	movq	0x68(%rcx), %rax
               	movq	%rax, 0x68(%rdx)
               	movq	0x70(%rcx), %rax
               	movq	%rax, 0x70(%rdx)
               	movq	0x78(%rcx), %rax
               	movq	%rax, 0x78(%rdx)
               	movq	0x80(%rcx), %rax
               	movq	%rax, 0x80(%rdx)
               	movq	0x88(%rcx), %rax
               	movq	%rax, 0x88(%rdx)
               	movq	0x90(%rcx), %rax
               	movq	%rax, 0x90(%rdx)
               	movq	0x98(%rcx), %rax
               	movq	%rax, 0x98(%rdx)
               	movq	0xa0(%rcx), %rax
               	movq	%rax, 0xa0(%rdx)
               	movq	0xa8(%rcx), %rax
               	movq	%rax, 0xa8(%rdx)
               	movq	0xb0(%rcx), %rax
               	movq	%rax, 0xb0(%rdx)
               	movq	0xb8(%rcx), %rax
               	movq	%rax, 0xb8(%rdx)
               	movq	0xc0(%rcx), %rax
               	movq	%rax, 0xc0(%rdx)
               	movq	0xc8(%rcx), %rax
               	movq	%rax, 0xc8(%rdx)
               	movq	0xd0(%rcx), %rax
               	movq	%rax, 0xd0(%rdx)
               	movq	0xd8(%rcx), %rax
               	movq	%rax, 0xd8(%rdx)
               	movq	0xe0(%rcx), %rax
               	movq	%rax, 0xe0(%rdx)
               	movq	0xe8(%rcx), %rax
               	movq	%rax, 0xe8(%rdx)
               	movq	0xf0(%rcx), %rax
               	movq	%rax, 0xf0(%rdx)
               	movq	0xf8(%rcx), %rax
               	movq	%rax, 0xf8(%rdx)
               	movq	0x100(%rcx), %rax
               	movq	%rax, 0x100(%rdx)
               	movq	0x108(%rcx), %rax
               	movq	%rax, 0x108(%rdx)
               	movq	0x110(%rcx), %rax
               	movq	%rax, 0x110(%rdx)
               	movq	0x118(%rcx), %rax
               	movq	%rax, 0x118(%rdx)
               	movq	0x120(%rcx), %rax
               	movq	%rax, 0x120(%rdx)
               	movq	0x128(%rcx), %rax
               	movq	%rax, 0x128(%rdx)
               	movq	0x130(%rcx), %rax
               	movq	%rax, 0x130(%rdx)
               	movq	0x138(%rcx), %rax
               	movq	%rax, 0x138(%rdx)
               	movq	0x140(%rcx), %rax
               	movq	%rax, 0x140(%rdx)
               	movq	0x148(%rcx), %rax
               	movq	%rax, 0x148(%rdx)
               	movq	0x150(%rcx), %rax
               	movq	%rax, 0x150(%rdx)
               	movq	0x158(%rcx), %rax
               	movq	%rax, 0x158(%rdx)
               	movq	0x160(%rcx), %rax
               	movq	%rax, 0x160(%rdx)
               	movq	0x168(%rcx), %rax
               	movq	%rax, 0x168(%rdx)
               	movq	0x170(%rcx), %rax
               	movq	%rax, 0x170(%rdx)
               	movq	0x178(%rcx), %rax
               	movq	%rax, 0x178(%rdx)
               	movq	0x180(%rcx), %rax
               	movq	%rax, 0x180(%rdx)
               	movq	0x188(%rcx), %rax
               	movq	%rax, 0x188(%rdx)
               	movq	0x190(%rcx), %rax
               	movq	%rax, 0x190(%rdx)
               	movq	0x198(%rcx), %rax
               	movq	%rax, 0x198(%rdx)
               	movq	0x1a0(%rcx), %rax
               	movq	%rax, 0x1a0(%rdx)
               	movq	0x1a8(%rcx), %rax
               	movq	%rax, 0x1a8(%rdx)
               	movq	0x1b0(%rcx), %rax
               	movq	%rax, 0x1b0(%rdx)
               	movq	0x1b8(%rcx), %rax
               	movq	%rax, 0x1b8(%rdx)
               	movq	0x1c0(%rcx), %rax
               	movq	%rax, 0x1c0(%rdx)
               	movq	0x1c8(%rcx), %rax
               	movq	%rax, 0x1c8(%rdx)
               	movq	0x1d0(%rcx), %rax
               	movq	%rax, 0x1d0(%rdx)
               	movq	0x1d8(%rcx), %rax
               	movq	%rax, 0x1d8(%rdx)
               	movq	0x1e0(%rcx), %rax
               	movq	%rax, 0x1e0(%rdx)
               	movq	0x1e8(%rcx), %rax
               	movq	%rax, 0x1e8(%rdx)
               	movq	0x1f0(%rcx), %rax
               	movq	%rax, 0x1f0(%rdx)
               	movq	0x1f8(%rcx), %rax
               	movq	%rax, 0x1f8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x200, %rcx            # imm = 0x200
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	xorq	%rbx, %rbx
               	movq	%rbx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	leaq	-<rip>, %rcx      # <addr>
               	movq	%rcx, (%rax)
               	movl	%ebx, 0x8(%rax)
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
