
reg_alloc_callee_bank_call_block_before_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<qs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r12
               	movslq	%esi, %rsi
               	movslq	%r12d, %r12
               	cmpq	%r12, %rsi
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rsi,%r12), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	$0x1, %rax
               	movslq	(%rbx,%rax,4), %rax
               	movq	%r12, %rdx
               	movq	%rsi, %r13
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %r13
               	movslq	%r13d, %rcx
               	movslq	(%rbx,%rcx,4), %rdi
               	cmpq	%rax, %rdi
               	jl	<addr>
               	jmp	<addr>
               	leaq	-0x1(%rdi), %rdx
               	movslq	%edx, %rdi
               	movslq	(%rbx,%rdi,4), %r8
               	cmpq	%rax, %r8
               	jg	<addr>
               	cmpq	%rdi, %rcx
               	jg	<addr>
               	movslq	(%rbx,%rcx,4), %r8
               	movslq	(%rbx,%rdi,4), %r9
               	movl	%r9d, (%rbx,%rcx,4)
               	movl	%r8d, (%rbx,%rdi,4)
               	incq	%r13
               	leaq	-0x1(%rdi), %rdx
               	jmp	<addr>
               	movslq	%r13d, %rcx
               	movslq	%edx, %rdi
               	cmpq	%rdi, %rcx
               	jle	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r13, %rsi
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movl	$0x3039, %edx           # imm = 0x3039
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	%edx, %edx
               	imulq	$0x41c64e6d, %rdx, %rdx # imm = 0x41C64E6D
               	movl	%edx, %edx
               	addq	$0x3039, %rdx           # imm = 0x3039
               	movl	%edx, %edx
               	leaq	-0x100(%rbp), %rsi
               	movl	%edx, %edi
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	movl	%edi, (%rsi,%rax,4)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x40, %rax
               	jl	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x3f, %edx
               	callq	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdx
               	movslq	(%rdx,%rax,4), %rdx
               	leaq	-0x100(%rbp), %rsi
               	leaq	-0x1(%rcx), %rdi
               	movslq	%edi, %rdi
               	movslq	(%rsi,%rdi,4), %rsi
               	cmpq	%rsi, %rdx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x40, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
