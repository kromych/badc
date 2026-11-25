
inline_asm_x64_raid6_syndrome.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0xc3, %edx
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorl	%r9d, %r9d
               	xorl	%eax, %eax
               	movq	%r9, %rdi
               	shlq	$0x8, %rdi
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	leaq	<rip>, %rsi # <addr>
               	leaq	(%rsi,%rdi), %r8
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	incq	%r9
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %r9d
               	jl	<addr>
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	leaq	<rip>, %rdi # <addr>
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x1d, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jb	<addr>
               	xorl	%edi, %edi
               	movb	%dil, <rip> # <addr>
               	movb	%dil, <rip> # <addr>
               	movb	$-0x3d, <rip> # <addr>
               	movl	$0x10, %ecx
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x2, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x20, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x3, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x30, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x4, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x40, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x5, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x50, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x6, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x60, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x7, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x70, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x8, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x80, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x9, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0x90, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xa, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xa0, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xb, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xb0, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xc, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xc0, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xd, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xd0, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xe, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xe0, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xf, %ecx
               	xorl	%edi, %edi
               	movq	%rdi, %rsi
               	movq	%rdx, %rax
               	movq	%rsi, %r8
               	xorq	%rax, %r8
               	testb	$0x1, %cl
               	cmovneq	%r8, %rsi
               	movq	%rax, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rdi, %r9
               	xorq	%r9, %r8
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movb	%sil, <rip> # <addr>
               	movl	$0xf0, %eax
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	movq	%rcx, %rdi
               	xorq	%rdx, %rdi
               	testb	$0x1, %al
               	cmovneq	%rdi, %rcx
               	movq	%rdx, %rdi
               	shlq	%rdi
               	movl	$0x1d, %r8d
               	testb	$-0x80, %dl
               	cmoveq	%rsi, %r8
               	xorq	%r8, %rdi
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	shrq	%rax
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	movb	%cl, <rip> # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rbx # <addr>
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x300(%rcx), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	leaq	0x200(%rcx), %r8
               	movzbq	(%r8,%rax), %rsi
               	xorq	%rdx, %rsi
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movl	$0x1d, %r12d
               	testb	$-0x80, %dl
               	cmoveq	%rdi, %r12
               	xorq	%r12, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%r8,%rax), %rdx
               	xorq	%rdx, %rcx
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x100(%rdx), %r8
               	movzbq	(%r8,%rax), %rdx
               	xorq	%rdx, %rsi
               	movq	%rcx, %rdx
               	shlq	%rdx
               	movl	$0x1d, %r12d
               	xorl	%r13d, %r13d
               	testb	$-0x80, %cl
               	cmoveq	%r13, %r12
               	xorq	%r12, %rdx
               	andq	$0xff, %rdx
               	movzbq	(%r8,%rax), %rcx
               	xorq	%rcx, %rdx
               	leaq	<rip>, %r8 # <addr>
               	movzbq	(%r8,%rax), %rcx
               	xorq	%rcx, %rsi
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movl	$0x1d, %r12d
               	xorl	%r13d, %r13d
               	testb	$-0x80, %dl
               	cmoveq	%r13, %r12
               	xorq	%r12, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%r8,%rax), %rdx
               	xorq	%rdx, %rcx
               	movb	%sil, (%r9,%rax)
               	movb	%cl, (%rbx,%rax)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	cmpl	$0x7, %eax
               	jae	<addr>
               	xorl	%r9d, %r9d
               	cmpl	$0x1, %r9d
               	jge	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x400(%rax), %rdi
               	leaq	0x500(%rax), %r8
               	xorl	%ecx, %ecx
               	vmovdqa	<rip>, %ymm0 # <addr>
               	vpxor	%ymm3, %ymm3, %ymm3
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x300(%rdx), %rsi
               	leaq	(%rsi,%rcx), %rax
               	prefetchnta	(%rax)
               	leaq	(%rsi,%rcx), %rax
               	vmovdqa	(%rax), %ymm2
               	vmovdqa	%ymm2, %ymm4
               	leaq	0x200(%rdx), %rax
               	addq	%rcx, %rax
               	vmovdqa	(%rax), %ymm6
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x100(%rdx), %rax
               	addq	%rcx, %rax
               	prefetchnta	(%rax)
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	0x100(%rdx), %rax
               	addq	%rcx, %rax
               	vmovdqa	(%rax), %ymm6
               	leaq	<rip>, %rdx # <addr>
               	leaq	(%rdx,%rcx), %rax
               	prefetchnta	(%rax)
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	(%rdx,%rcx), %rax
               	vmovdqa	(%rax), %ymm6
               	vpcmpgtb	%ymm4, %ymm3, %ymm5
               	vpaddb	%ymm4, %ymm4, %ymm4
               	vpand	%ymm0, %ymm5, %ymm5
               	vpxor	%ymm5, %ymm4, %ymm4
               	vpxor	%ymm6, %ymm2, %ymm2
               	vpxor	%ymm6, %ymm4, %ymm4
               	leaq	(%rdi,%rcx), %rax
               	vmovntdq	%ymm2, (%rax)
               	leaq	(%r8,%rcx), %rax
               	vmovntdq	%ymm4, (%rax)
               	addq	$0x20, %rcx
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0x100, %ecx            # imm = 0x100
               	jb	<addr>
               	sfence
               	vzeroupper
               	leaq	<rip>, %rax # <addr>
               	leaq	0x400(%rax), %rsi
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rcx
               	movzbq	(%rdi,%rax), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x500(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	vpbroadcastb	<rip>, %ymm7 # <addr>
               	vbroadcasti128	<rip>, %ymm4 # ymm4 = mem[0,1,0,1]
                                                # <addr>
               	vbroadcasti128	<rip>, %ymm5 # ymm5 = mem[0,1,0,1]
                                                # <addr>
               	vmovdqa	<rip>, %ymm1 # <addr>
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip> # <addr>
               	vmovdqa	<rip>, %ymm1 # <addr>
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip> # <addr>
               	vmovdqa	<rip>, %ymm1 # <addr>
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip> # <addr>
               	vmovdqa	<rip>, %ymm1 # <addr>
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip> # <addr>
               	vmovdqa	<rip>, %ymm1 # <addr>
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip> # <addr>
               	vmovdqa	<rip>, %ymm1 # <addr>
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip> # <addr>
               	vmovdqa	<rip>, %ymm1 # <addr>
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip> # <addr>
               	vmovdqa	<rip>, %ymm1 # <addr>
               	vpsraw	$0x4, %ymm1, %ymm3
               	vpand	%ymm7, %ymm1, %ymm1
               	vpand	%ymm7, %ymm3, %ymm3
               	vpshufb	%ymm1, %ymm4, %ymm1
               	vpshufb	%ymm3, %ymm5, %ymm3
               	vpxor	%ymm1, %ymm3, %ymm3
               	vmovdqa	%ymm3, <rip> # <addr>
               	vzeroupper
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax,%rbx), %r12
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax,%rbx), %rax
               	movl	$0xc3, %ecx
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	movq	%rdx, %rdi
               	xorq	%rax, %rdi
               	testb	$0x1, %cl
               	cmovneq	%rdi, %rdx
               	movq	%rax, %rdi
               	shlq	%rdi
               	movl	$0x1d, %r8d
               	testb	$-0x80, %al
               	cmoveq	%rsi, %r8
               	xorq	%r8, %rdi
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	%edx, %r12d
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x100, %ebx            # imm = 0x100
               	jb	<addr>
               	cmpl	$0x2, %r9d
               	jge	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x400(%rdx), %rsi
               	addq	$0x500, %rdx            # imm = 0x500
               	leaq	<rip>, %rdi # <addr>
               	movb	%cl, (%rdi,%rax)
               	movb	%cl, (%rdx,%rax)
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	vmovdqa64	<rip>, %zmm0 # <addr>
               	vpxorq	%zmm1, %zmm1, %zmm1
               	prefetchnta	<rip> # <addr>
               	vmovdqa64	<rip>, %zmm2 # <addr>
               	vmovdqa64	%zmm2, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	prefetchnta	<rip> # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	prefetchnta	<rip> # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovntdq	%zmm2, <rip> # <addr>
               	vmovntdq	%zmm4, <rip> # <addr>
               	prefetchnta	<rip> # <addr>
               	vmovdqa64	<rip>, %zmm2 # <addr>
               	vmovdqa64	%zmm2, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	prefetchnta	<rip> # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	prefetchnta	<rip> # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovntdq	%zmm2, <rip> # <addr>
               	vmovntdq	%zmm4, <rip> # <addr>
               	prefetchnta	<rip> # <addr>
               	vmovdqa64	<rip>, %zmm2 # <addr>
               	vmovdqa64	%zmm2, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	prefetchnta	<rip> # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	prefetchnta	<rip> # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovntdq	%zmm2, <rip> # <addr>
               	vmovntdq	%zmm4, <rip> # <addr>
               	prefetchnta	<rip> # <addr>
               	vmovdqa64	<rip>, %zmm2 # <addr>
               	vmovdqa64	%zmm2, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	prefetchnta	<rip> # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	prefetchnta	<rip> # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovdqa64	<rip>, %zmm6 # <addr>
               	vpcmpgtb	%zmm4, %zmm1, %k1
               	vpmovm2b	%k1, %zmm5
               	vpaddb	%zmm4, %zmm4, %zmm4
               	vpandq	%zmm0, %zmm5, %zmm5
               	vpxorq	%zmm5, %zmm4, %zmm4
               	vpxorq	%zmm6, %zmm2, %zmm2
               	vpxorq	%zmm6, %zmm4, %zmm4
               	vmovntdq	%zmm2, <rip> # <addr>
               	vmovntdq	%zmm4, <rip> # <addr>
               	sfence
               	vzeroupper
               	leaq	<rip>, %rax # <addr>
               	leaq	0x400(%rax), %rsi
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rcx
               	movzbq	(%rdi,%rax), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x500(%rax), %rcx
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jb	<addr>
               	vpbroadcastb	<rip>, %zmm7 # <addr>
               	vbroadcasti64x2	<rip>, %zmm4 # zmm4 = mem[0,1,0,1,0,1,0,1]
                                                # <addr>
               	vbroadcasti64x2	<rip>, %zmm5 # zmm5 = mem[0,1,0,1,0,1,0,1]
                                                # <addr>
               	vmovdqa64	<rip>, %zmm1 # <addr>
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	vmovdqa64	%zmm3, <rip> # <addr>
               	vmovdqa64	<rip>, %zmm1 # <addr>
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	vmovdqa64	%zmm3, <rip> # <addr>
               	vmovdqa64	<rip>, %zmm1 # <addr>
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	vmovdqa64	%zmm3, <rip> # <addr>
               	vmovdqa64	<rip>, %zmm1 # <addr>
               	vpsraw	$0x4, %zmm1, %zmm3
               	vpandq	%zmm7, %zmm1, %zmm1
               	vpandq	%zmm7, %zmm3, %zmm3
               	vpshufb	%zmm1, %zmm4, %zmm1
               	vpshufb	%zmm3, %zmm5, %zmm3
               	vpxorq	%zmm1, %zmm3, %zmm3
               	vmovdqa64	%zmm3, <rip> # <addr>
               	vzeroupper
               	xorl	%r8d, %r8d
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax,%r8), %rbx
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax,%r8), %rax
               	movl	$0xc3, %ecx
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	movq	%rdx, %rdi
               	xorq	%rax, %rdi
               	testb	$0x1, %cl
               	cmovneq	%rdi, %rdx
               	movq	%rax, %rdi
               	shlq	%rdi
               	movl	$0x1d, %r9d
               	testb	$-0x80, %al
               	cmoveq	%rsi, %r9
               	xorq	%r9, %rdi
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	shrq	%rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	%edx, %ebx
               	jne	<addr>
               	incq	%r8
               	nop
               	cmpl	$0x100, %r8d            # imm = 0x100
               	jb	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	testl	$0x8000000, %ecx        # imm = 0x8000000
               	jne	<addr>
               	xorl	%r9d, %r9d
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	xgetbv
               	movq	%rax, %rsi
               	movq	%rsi, %rax
               	andq	$0x6, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	xorl	%r9d, %r9d
               	jmp	<addr>
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	testb	$0x20, %bl
               	jne	<addr>
               	xorl	%r9d, %r9d
               	jmp	<addr>
               	testl	$0x10000, %ebx          # imm = 0x10000
               	je	<addr>
               	testl	$0x40000000, %ebx       # imm = 0x40000000
               	je	<addr>
               	andq	$0xe0, %rsi
               	cmpl	$0xe0, %esi
               	jne	<addr>
               	movl	$0x2, %r9d
               	jmp	<addr>
               	movl	$0x1, %r9d
               	jmp	<addr>
