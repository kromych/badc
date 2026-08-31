
alloca_call_args.x64:	file format elf64-x86-64

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

<sum10>:
               	popq	%r10
               	subq	$0xa0, %rsp
               	movq	0xa0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x90(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0xa0(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xa0, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x100000, %eax         # imm = 0x100000
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movl	$0x7, %edx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rcx,%rax), %rsi
               	movb	%dl, (%rsi)
               	addq	$0x1000, %rax           # imm = 0x1000
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	jl	<addr>
               	leaq	0xfffff(%rcx), %rax
               	movl	$0x8, %esi
               	movb	%sil, (%rax)
               	movsbq	(%rcx), %rax
               	addq	$0x8, %rax
               	movslq	%eax, %r15
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %ecx
               	movl	$0x4, %r8d
               	movl	$0x5, %r9d
               	movl	$0x6, %ebx
               	movl	$0x8, %r12d
               	movl	$0x9, %r13d
               	movl	$0xa, %r14d
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	subq	$0x20, %rsp
               	movq	%rdx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rcx, %rdx
               	movq	%r8, %rcx
               	movq	%r9, %r8
               	movq	%rbx, %r9
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpl	$0xf, %r15d
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x37, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
