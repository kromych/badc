
arm_acle_crc32_and_sha.x64:	file format elf64-x86-64

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

<crc_model>:
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	xorl	%edx, %edx
               	movzbq	(%rsi,%rdx), %rdi
               	xorq	%rax, %rdi
               	movl	%edi, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	andq	$0x1, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	andq	$0x1, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	andq	$0x1, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	andq	$0x1, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	andq	$0x1, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	andq	$0x1, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	andq	$0x1, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdi
               	shrq	%rdi
               	andq	$0x1, %rax
               	negq	%rax
               	andq	%rcx, %rax
               	xorq	%rdi, %rax
               	incq	%rdx
               	cmpl	$0x9, %edx
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	xorl	%eax, %eax
               	imulq	$0x25, %rax, %rdx
               	addq	$0xb, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x40(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x3d, %eax
               	jl	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	leaq	<rip>, %rsi
               	movl	$0x9, %edx
               	movl	$0xedb88320, %ecx       # imm = 0xEDB88320
               	callq	<addr>
               	cmpl	$0x340bc6d9, %eax       # imm = 0x340BC6D9
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	leaq	<rip>, %rsi
               	movl	$0x9, %edx
               	movl	$0x82f63b78, %ecx       # imm = 0x82F63B78
               	callq	<addr>
               	cmpl	$0x1cf96d7c, %eax       # imm = 0x1CF96D7C
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
