
inline_struct_return_multi_block.x64:	file format elf64-x86-64

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

<reg_slot>:
               	testl	%esi, %esi
               	jne	<addr>
               	movq	$-0x1, %rax
               	retq
               	movq	%rsi, %rax
               	andq	$0x3, %rax
               	movslq	(%rdi,%rax,4), %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x20, -0x8(%rbp)
               	leaq	<rip>, %rdi
               	movl	-0x8(%rbp), %eax
               	leaq	<rip>, %rdx
               	shrq	$0x5, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x1, (%rcx)
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	<rip>, %rcx
               	movl	$0x1, (%rcx)
               	imulq	$0x18, %rax, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	leaq	<rip>, %r8
               	movl	$0x1, (%r8)
               	movl	(%rcx), %eax
               	movl	0x4(%rcx), %r8d
               	movzwq	0x8(%rcx), %rdx
               	movzbq	0xa(%rcx), %r9
               	movzbq	0xb(%rcx), %rsi
               	movq	0x10(%rcx), %rbx
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	$-0x1, %rax
               	cmpq	$0x100f1, %rax          # imm = 0x100F1
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movslq	%r8d, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movsbq	%r9b, %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movq	%rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	jmp	<addr>
               	andq	$0x3, %rax
               	movslq	(%rdi,%rax,4), %rax
               	jmp	<addr>
