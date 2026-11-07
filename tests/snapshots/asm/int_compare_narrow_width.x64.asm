
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
               	movq	<rip>, %rax # <addr>
               	movslq	%eax, %rdi
               	movq	<rip>, %rax # <addr>
               	movslq	%eax, %rcx
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r8 # <addr>
               	testl	%edi, %edi
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	%ecx, %edi
               	jl	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	%edi, %ecx
               	jg	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x80000001, %edi       # imm = 0x80000001
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpl	%ecx, %edi
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0xc, %ecx
               	jg	<addr>
               	cmpl	$0xc, %ecx
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
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	ja	<addr>
               	movl	$0x9, %eax
               	retq
               	cmpl	%eax, %ecx
               	jbe	<addr>
               	movl	$0xb, %eax
               	retq
               	cmpl	$0x80000001, %eax       # imm = 0x80000001
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	jg	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	cmpl	$0x90, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	%rcx, %rax
               	shlq	$0x4, %rax
               	cmpl	$0xc0, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rdi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	imulq	$0x7, %rax, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	cmpl	$-0x1, %edx
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	%al, %rax
               	movq	<rip>, %rdx # <addr>
               	andq	$0xff, %rdx
               	movq	<rip>, %rsi # <addr>
               	movswq	%si, %rsi
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$-0x6e, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	retq
               	testl	%edx, %edx
               	jle	<addr>
               	cmpl	$0x92, %edx
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	cmpl	%esi, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	(%rax,%rax,2), %rsi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %edx
               	cmpl	$0x24, %edx
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	movslq	%r8d, %rdx
               	movl	(%rax,%rdx,4), %edx
               	cmpl	$0x24, %edx
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	leaq	-0x5(%rcx), %rdx
               	movslq	%edx, %rdx
               	movl	(%rax,%rdx,4), %esi
               	addq	%rdi, %rsi
               	movl	%esi, (%rax,%rdx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x80000016, %eax       # imm = 0x80000016
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	cmpl	$-0x5, %ecx
               	jge	<addr>
               	movl	$0x26, %eax
               	retq
               	cmpl	$0x5, %ecx
               	jle	<addr>
               	xorl	%eax, %eax
               	retq
