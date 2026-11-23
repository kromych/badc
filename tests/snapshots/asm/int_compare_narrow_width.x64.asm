
int_compare_narrow_width.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movslq	%eax, %rcx
               	movq	<rip>, %rax # <addr>
               	movslq	%eax, %rax
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rdi # <addr>
               	testl	%ecx, %ecx
               	jl	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	%eax, %ecx
               	jl	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	%ecx, %eax
               	jg	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x80000001, %ecx       # imm = 0x80000001
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0xc, %eax
               	jg	<addr>
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpl	%edi, %edx
               	ja	<addr>
               	movl	$0x7, %eax
               	retq
               	cmpl	%edi, %edx
               	jl	<addr>
               	movl	$0x8, %eax
               	retq
               	cmpl	$0x80000000, %edx       # imm = 0x80000000
               	ja	<addr>
               	movl	$0x9, %eax
               	retq
               	cmpl	%edx, %eax
               	jbe	<addr>
               	movl	$0xb, %eax
               	retq
               	cmpl	$0x80000001, %edx       # imm = 0x80000001
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rdx
               	jg	<addr>
               	movl	$0x10, %eax
               	retq
               	movq	%rax, %rdx
               	imulq	%rax, %rdx
               	cmpl	$0x90, %edx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	cmpl	$0xc0, %edx
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	movq	%rax, %rdx
               	sarq	$0x2, %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	movl	$0x92492493, %edx       # imm = 0x92492493
               	imulq	%rcx, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	cmpl	$-0x1, %esi
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	movsbq	%dl, %rdx
               	movq	<rip>, %rsi # <addr>
               	andq	$0xff, %rsi
               	movq	<rip>, %r8 # <addr>
               	movswq	%r8w, %r8
               	testl	%edx, %edx
               	jge	<addr>
               	cmpl	$-0x6e, %edx
               	je	<addr>
               	movl	$0x1d, %eax
               	retq
               	testl	%esi, %esi
               	jle	<addr>
               	cmpl	$0x92, %esi
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	cmpl	%r8d, %edx
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	xorl	%edx, %edx
               	leaq	<rip>, %rsi # <addr>
               	leaq	(%rdx,%rdx,2), %r8
               	movl	%r8d, (%rsi,%rdx,4)
               	incq	%rdx
               	cmpl	$0x14, %edx
               	jl	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx,%rax,4), %esi
               	cmpl	$0x24, %esi
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	movslq	%edi, %rsi
               	movl	(%rdx,%rsi,4), %esi
               	cmpl	$0x24, %esi
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	leaq	-0x5(%rax), %rsi
               	movslq	%esi, %rsi
               	movl	(%rdx,%rsi,4), %edi
               	addq	%rdi, %rcx
               	movl	%ecx, (%rdx,%rsi,4)
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x80000016, %ecx       # imm = 0x80000016
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	cmpl	$-0x5, %eax
               	jge	<addr>
               	movl	$0x26, %eax
               	retq
               	cmpl	$0x5, %eax
               	jle	<addr>
               	xorl	%eax, %eax
               	retq
