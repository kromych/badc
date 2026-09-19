
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
               	movslq	%eax, %rdi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	movslq	%eax, %rsi
               	movq	(%rcx), %rax
               	movq	(%rdx), %r8
               	testl	%edi, %edi
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	%esi, %edi
               	jl	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	%edi, %esi
               	jg	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x80000001, %edi       # imm = 0x80000001
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0xc, %esi
               	jg	<addr>
               	cmpl	$0xc, %esi
               	jge	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpl	%r8d, %eax
               	ja	<addr>
               	movl	$0x7, %eax
               	retq
               	cmpl	%r8d, %eax
               	jl	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rax, %rdx
               	cmpl	%r11d, %eax
               	ja	<addr>
               	movl	$0x9, %eax
               	retq
               	cmpl	%eax, %esi
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
               	movq	%rsi, %rax
               	imulq	%rsi, %rax
               	cmpl	$0x90, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	%rsi, %rax
               	shlq	$0x4, %rax
               	cmpl	$0xc0, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rsi, %rax
               	sarq	$0x2, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rdi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	imulq	$0x7, %rax, %rax
               	movq	%rdi, %rcx
               	subq	%rax, %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movsbq	%al, %rdx
               	movq	(%rcx), %rax
               	andq	$0xff, %rax
               	movq	(%rcx), %rcx
               	movswq	%cx, %r9
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
               	cmpl	%r9d, %edx
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	cmpl	$0x14, %eax
               	jge	<addr>
               	leaq	(%rax,%rax,2), %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax,%rsi,4), %rcx
               	cmpl	$0x24, %ecx
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	movslq	%r8d, %rcx
               	movslq	(%rax,%rcx,4), %rcx
               	cmpl	$0x24, %ecx
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	leaq	-0x5(%rsi), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rax,%rcx,4), %rdx
               	addq	%rdi, %rdx
               	movl	%edx, (%rax,%rcx,4)
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x80000016, %eax       # imm = 0x80000016
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	cmpl	$-0x5, %esi
               	jge	<addr>
               	movq	$-0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x26, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	cmpl	$0x5, %esi
               	jle	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
