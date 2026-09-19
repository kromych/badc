
int_compare_narrow_width.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movslq	%eax, %r8
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	movslq	%eax, %rdi
               	movq	(%rcx), %rax
               	movl	%eax, %eax
               	movq	(%rdx), %rdx
               	movl	%edx, %r9d
               	testl	%r8d, %r8d
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	%edi, %r8d
               	jl	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	%r8d, %edi
               	jg	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x80000001, %r8d       # imm = 0x80000001
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpl	%edi, %r8d
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0xc, %edi
               	jg	<addr>
               	cmpl	$0xc, %edi
               	jge	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpl	%r9d, %eax
               	ja	<addr>
               	movl	$0x7, %eax
               	retq
               	cmpl	%r9d, %eax
               	jl	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rax, %rdx
               	cmpl	%r11d, %eax
               	ja	<addr>
               	movl	$0x9, %eax
               	retq
               	movl	%edi, %edx
               	cmpl	%eax, %edx
               	jbe	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	(%rcx), %rax
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	jg	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	%rdi, %rax
               	imulq	%rdi, %rax
               	cmpl	$0x90, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	%rdi, %rax
               	shlq	$0x4, %rax
               	cmpl	$0xc0, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rdi, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%r8, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %rax, %rax
               	movq	%rax, %r10
               	movq	%r8, %rax
               	subq	%r10, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movsbq	%al, %rdx
               	movq	(%rcx), %rax
               	andq	$0xff, %rax
               	movq	(%rcx), %rcx
               	movswq	%cx, %rsi
               	testl	%edx, %edx
               	jge	<addr>
               	cmpl	$-0x6e, %edx
               	je	<addr>
               	movl	$0x1d, %eax
               	retq
               	testl	%eax, %eax
               	jle	<addr>
               	xorq	$0x92, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	cmpl	%esi, %edx
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi
               	cmpl	$0x14, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rcx,%rcx,2), %rdx
               	movl	%edx, (%rsi,%rcx,4)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdi,4), %rax
               	cmpl	$0x24, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	%r9d, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	cmpl	$0x24, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	leaq	-0x5(%rdi), %rax
               	movslq	%eax, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rdx
               	addq	%r8, %rdx
               	movl	%edx, (%rax,%rcx,4)
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x80000016, %eax       # imm = 0x80000016
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	cmpl	$-0x5, %edi
               	jge	<addr>
               	movabsq	$-0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	cmpl	$0x5, %edi
               	jle	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
