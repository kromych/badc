
slot_coalesce_block_arrays.x64:	file format elf64-x86-64

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

<tally>:
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rdi,%rcx,8), %r8
               	addq	%r8, %rdx
               	leaq	0x1(%rcx), %rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rdx, %rax
               	retq

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x410, %rsp            # imm = 0x410
               	movq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	xorq	%rax, %rax
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	cmpl	$0x4, %ecx
               	je	<addr>
               	addq	$0x410, %rsp            # imm = 0x410
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x200(%rbp), %rsi
               	movslq	%eax, %rcx
               	leaq	(%rcx,%rcx,2), %rdi
               	movslq	%edi, %rdi
               	addq	$0x3e8, %rdi            # imm = 0x3E8
               	movq	%rdi, (%rsi,%rcx,8)
               	leaq	0x1(%rcx), %rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	movq	%rdx, %rsi
               	callq	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %r8
               	movslq	%ecx, %rsi
               	movq	%rdi, %r9
               	xorq	%rsi, %r9
               	movq	%r9, (%r8,%rsi,8)
               	leaq	0x1(%rsi), %rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movslq	%ecx, %rsi
               	movq	(%rdi,%rsi,8), %rdi
               	addq	%rdi, %rax
               	leaq	0x1(%rsi), %rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %r8
               	movslq	%ecx, %rsi
               	movq	%rdi, %r9
               	subq	%rsi, %r9
               	movq	%r9, (%r8,%rsi,8)
               	leaq	0x1(%rsi), %rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movslq	%ecx, %rsi
               	movq	(%rdi,%rsi,8), %rdi
               	addq	%rdi, %rax
               	leaq	0x1(%rsi), %rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %ecx
               	jl	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %r8
               	movslq	%ecx, %rsi
               	movq	%rdi, %r9
               	imulq	%rsi, %r9
               	movq	%r9, (%r8,%rsi,8)
               	leaq	0x1(%rsi), %rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movslq	%ecx, %rsi
               	movq	(%rdi,%rsi,8), %rdi
               	addq	%rdi, %rax
               	leaq	0x1(%rsi), %rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movslq	%ecx, %rsi
               	leaq	0x3e8(%rsi), %r8
               	movq	%r8, (%rdi,%rsi,8)
               	leaq	0x1(%rsi), %rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movslq	%ecx, %rsi
               	movq	(%rdi,%rsi,8), %rdi
               	addq	%rdi, %rax
               	leaq	0x1(%rsi), %rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %r13
               	movl	$0x3e8, %ebx            # imm = 0x3E8
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	movq	%r13, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	(%rax), %r14
               	movl	$0x1, %edi
               	movq	%rbx, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	addq	%rax, %r14
               	movl	$0x2, %edi
               	movq	%rbx, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	addq	%rax, %r14
               	movl	$0x3, %edi
               	movq	%rbx, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	addq	%rax, %r14
               	movl	$0x4, %edi
               	movq	%rbx, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	leaq	(%r14,%rax), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	0x3e8(%rcx), %rdx
               	movq	%rbx, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rdx
               	movq	%rbx, %rsi
               	subq	%rcx, %rsi
               	addq	%rsi, %rdx
               	movq	%rbx, %rsi
               	xorq	%rcx, %rsi
               	addq	%rdx, %rsi
               	leaq	(%rcx,%rcx,2), %rdx
               	movslq	%edx, %rdx
               	addq	$0x3e8, %rdx            # imm = 0x3E8
               	addq	%rsi, %rdx
               	addq	%rdx, %r12
               	leaq	0x1(%rcx), %rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	cmpq	%r12, %rdi
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
