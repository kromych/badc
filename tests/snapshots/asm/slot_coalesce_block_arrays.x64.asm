
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
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x400, %rsp            # imm = 0x400
               	movslq	%edx, %rdx
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	xorq	%rax, %rax
               	cmpl	$0x2, %edi
               	jl	<addr>
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x4, %edi
               	jl	<addr>
               	xorq	%rax, %rax
               	cmpl	%edx, %eax
               	jge	<addr>
               	leaq	-0x200(%rbp), %rsi
               	movslq	%eax, %rcx
               	leaq	(%rcx,%rcx,2), %rdi
               	movslq	%edi, %rdi
               	addq	$0x3e8, %rdi            # imm = 0x3E8
               	movq	%rdi, (%rsi,%rcx,8)
               	incq	%rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	movq	%rdx, %rsi
               	callq	<addr>
               	leave
               	retq
               	xorq	%rcx, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %r8
               	movslq	%ecx, %rdi
               	movq	%rsi, %r9
               	xorq	%rdi, %r9
               	movq	%r9, (%r8,%rdi,8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movslq	%ecx, %rdi
               	movq	(%rsi,%rdi,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %r8
               	movslq	%ecx, %rdi
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movq	%r9, (%r8,%rdi,8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movslq	%ecx, %rdi
               	movq	(%rsi,%rdi,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	jl	<addr>
               	movq	%rax, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %r8
               	movslq	%ecx, %rdi
               	movq	%rsi, %r9
               	imulq	%rdi, %r9
               	movq	%r9, (%r8,%rdi,8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movslq	%ecx, %rdi
               	movq	(%rsi,%rdi,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movslq	%ecx, %rsi
               	leaq	0x3e8(%rsi), %r8
               	movq	%r8, (%rdi,%rsi,8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movslq	%ecx, %rdi
               	movq	(%rsi,%rdi,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
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
               	cmpl	%r13d, %eax
               	jge	<addr>
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
               	addq	%rsi, %rdx
               	leaq	(%rcx,%rcx,2), %rcx
               	movslq	%ecx, %rcx
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	addq	%rdx, %rcx
               	addq	%rcx, %r12
               	incq	%rax
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
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
