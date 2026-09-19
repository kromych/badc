
reg_alloc_callee_bank_call_block_before_loop.x64:	file format elf64-x86-64

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

<qs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movslq	%edx, %r13
               	movslq	%esi, %r8
               	cmpl	%r13d, %r8d
               	jge	<addr>
               	leaq	(%r8,%r13), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movslq	(%r12,%rax,4), %rax
               	movq	%r13, %rdx
               	movq	%r8, %rbx
               	jmp	<addr>
               	incq	%rbx
               	movslq	%ebx, %rsi
               	movslq	(%r12,%rsi,4), %rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	movslq	%edx, %rcx
               	movslq	(%r12,%rcx,4), %rdi
               	cmpl	%eax, %edi
               	jle	<addr>
               	decq	%rdx
               	movslq	%edx, %rcx
               	movslq	(%r12,%rcx,4), %rdi
               	cmpl	%eax, %edi
               	jg	<addr>
               	cmpl	%edx, %ebx
               	jg	<addr>
               	movslq	(%r12,%rsi,4), %rdi
               	movslq	(%r12,%rcx,4), %r9
               	movl	%r9d, (%r12,%rsi,4)
               	movl	%edi, (%r12,%rcx,4)
               	incq	%rbx
               	decq	%rdx
               	cmpl	%edx, %ebx
               	jle	<addr>
               	movq	%r12, %rdi
               	movq	%r8, %rsi
               	callq	<addr>
               	movslq	%ebx, %r8
               	cmpl	%r13d, %r8d
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%rbx
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	leaq	-0x100(%rbp), %rsi
               	movq	%rcx, %rdx
               	andq	$0x7fffffff, %rdx       # imm = 0x7FFFFFFF
               	movl	%edx, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x100(%rbp), %rbx
               	xorl	%esi, %esi
               	movl	$0x3f, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x1, %eax
               	movslq	(%rbx,%rax,4), %rsi
               	leaq	-0x100(%rbp), %rdx
               	leaq	-0x1(%rax), %rcx
               	movslq	(%rdx,%rcx,4), %rcx
               	cmpl	%ecx, %esi
               	jl	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
