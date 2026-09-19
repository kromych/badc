
vla_scope_reclaim_loop.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorq	%rdi, %rdi
               	movq	%rdi, %r8
               	cmpl	$0x186a0, %edi          # imm = 0x186A0
               	jge	<addr>
               	movq	%rsp, %r9
               	movl	$0x100, %eax            # imm = 0x100
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
               	xorq	%rax, %rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movl	%eax, (%rcx,%rdx,4)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	andq	$0x3f, %rax
               	movslq	(%rcx,%rax,4), %rax
               	addq	%rax, %r8
               	movq	%r9, %rsp
               	incq	%rdi
               	cmpl	$0x186a0, %edi          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jge	<addr>
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	cmpq	%rcx, %r8
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
