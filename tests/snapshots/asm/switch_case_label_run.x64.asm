
switch_case_label_run.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	cmpq	$0x7d1, %rdi            # imm = 0x7D1
               	jae	<addr>
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rdi,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	pushq	%rax
               	<unknown>
               	addb	%al, (%rax)
               	pushq	%rdx
               	<unknown>
               	addb	%al, (%rax)
               	pushq	%rsp
               	<unknown>
               	addb	%al, (%rax)
               	pushq	%rsi
               	<unknown>
               	addb	%al, (%rax)
               	popq	%rax
               	<unknown>
               	addb	%al, (%rax)
               	popq	%rdx
               	<unknown>
               	addb	%al, (%rax)
               	popq	%rsp
               	<unknown>
               	addb	%al, (%rax)
               	popq	%rsi
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	pushq	$0x6a00001f             # imm = 0x6A00001F
               	<unknown>
               	addb	%al, (%rax)
               	insb	%dx, %es:(%rdi)
               	<unknown>
               	addb	%al, (%rax)
               	outsb	(%rsi), %dx
               	<unknown>
               	addb	%al, (%rax)
               	jo	<addr>
               	addb	%al, (%rax)
               	jb	<addr>
               	addb	%al, (%rax)
               	je	<addr>
               	addb	%al, (%rax)
               	jbe	<addr>
               	addb	%al, (%rax)
               	js	<addr>
               	addb	%al, (%rax)
               	jp	<addr>
               	addb	%al, (%rax)
               	jl	<addr>
               	addb	%al, (%rax)
               	jle	<addr>
               	addb	%al, (%rax)
               	sbbb	$0x0, (%rdi)
               	addb	%al, -0x7bffffe1(%rdx)
               	<unknown>
               	addb	%al, (%rax)
               	xchgb	%bl, (%rdi)
               	addb	%al, (%rax)
               	movb	%bl, (%rdi)
               	addb	%al, (%rax)
               	movb	(%rdi), %bl
               	addb	%al, (%rax)
               	movw	%ds, (%rdi)
               	addb	%al, (%rax)
               	movw	(%rdi), %ds
               	addb	%al, (%rax)
               	nop
               	<unknown>
               	addb	%al, (%rax)
               	xchgl	%edx, %eax
               	<unknown>
               	addb	%al, (%rax)
               	xchgl	%esp, %eax
               	<unknown>
               	addb	%al, (%rax)
               	xchgl	%esi, %eax
               	<unknown>
               	addb	%al, (%rax)
               	cwtl
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	pushfq
               	<unknown>
               	addb	%al, (%rax)
               	sahf
               	<unknown>
               	addb	%al, (%rax)
               	movabsb	-0x5bffffe05dffffe1, %al
               	<unknown>
               	addb	%al, (%rax)
               	cmpsb	%es:(%rdi), (%rsi)
               	<unknown>
               	addb	%al, (%rax)
               	testb	$0x1f, %al
               	addb	%al, (%rax)
               	stosb	%al, %es:(%rdi)
               	<unknown>
               	addb	%al, (%rax)
               	lodsb	(%rsi), %al
               	<unknown>
               	addb	%al, (%rax)
               	scasb	%es:(%rdi), %al
               	<unknown>
               	addb	%al, (%rax)
               	movb	$0x1f, %al
               	addb	%al, (%rax)
               	movb	$0x1f, %dl
               	addb	%al, (%rax)
               	movb	$0x1f, %ah
               	addb	%al, (%rax)
               	movb	$0x1f, %dh
               	addb	%al, (%rax)
               	movl	$0xba00001f, %eax       # imm = 0xBA00001F
               	<unknown>
               	addb	%al, (%rax)
               	movl	$0xbe00001f, %esp       # imm = 0xBE00001F
               	<unknown>
               	addb	%al, (%rax)
               	rcrb	$0x0, (%rdi)
               	addb	%al, %dl
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%cl, %cl
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	rcrl	%cl, (%rdi)
               	addb	%al, (%rax)
               	fcomps	(%rdi)
               	addb	%al, (%rax)
               	fstpl	(%rdi)
               	addb	%al, (%rax)
               	loop	<addr>
               	addb	%al, (%rax)
               	outl	%eax, $0x1f
               	addb	%al, (%rax)
               	inb	%dx, %al
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	negb	(%rdi)
               	addb	%al, (%rax)
               	sti
               	<unknown>
               	addb	%al, (%rax)
               	addb	%ah, (%rax)
               	addb	%al, (%rax)
               	addl	$0xa000020, %eax        # imm = 0xA000020
               	andb	%al, (%rax)
               	addb	%cl, (%rdi)
               	andb	%al, (%rax)
               	addb	%dl, (%rax,%riz)
               	addb	%al, (%rax)
               	sbbl	%esp, (%rax)
               	addb	%al, (%rax)
               	<unknown>
               	andb	%al, (%rax)
               	addb	%ah, (%rbx)
               	andb	%al, (%rax)
               	addb	%ch, (%rax)
               	andb	%al, (%rax)
               	addb	%ch, <rip>
               	andb	%al, (%rax)
               	addb	%dh, (%rdi)
               	andb	%al, (%rax)
               	addb	%bh, (%rax,%riz)
               	addb	%al, (%rax)
               	andb	%al, (%r8)
               	addb	%al, 0x20(%rsi)
               	addb	%al, (%rax)
               	andb	%al, (%r8)
               	addb	%dl, 0x20(%rax)
               	addb	%al, (%rax)
               	pushq	%rbp
               	andb	%al, (%rax)
               	addb	%bl, 0x20(%rdx)
               	addb	%al, (%rax)
               	popq	%rdi
               	andb	%al, (%rax)
               	addb	%ah, (%rax,%riz)
               	addb	%ch, 0x20(%rcx)
               	addb	%al, (%rax)
               	outsb	(%rsi), %dx
               	andb	%al, (%rax)
               	addb	%dh, 0x20(%rbx)
               	addb	%al, (%rax)
               	js	<addr>
               	addb	%al, (%rax)
               	jge	<addr>
               	addb	%al, (%rax)
               	<unknown>
               	andb	%al, (%rax)
               	addb	%al, -0x73ffffe0(%rdi)
               	andb	%al, (%rax)
               	addb	%dl, -0x69ffffe0(%rcx)
               	andb	%al, (%rax)
               	addb	%bl, -0x5fffffe0(%rbx)
               	andb	%al, (%rax)
               	addb	%ah, -0x55ffffe0(%rbp)
               	andb	%al, (%rax)
               	addb	%ch, -0x4bffffe0(%rdi)
               	andb	%al, (%rax)
               	addb	%bh, -0x41ffffe0(%rcx)
               	andb	%al, (%rax)
               	addb	%al, %bl
               	andb	%al, (%rax)
               	addb	%cl, %al
               	andb	%al, (%rax)
               	addb	%cl, %ch
               	andb	%al, (%rax)
               	addb	%dl, %dl
               	andb	%al, (%rax)
               	addb	%dl, %bh
               	andb	%al, (%rax)
               	addb	%bl, %ah
               	andb	%al, (%rax)
               	addb	%ah, %cl
               	andb	%al, (%rax)
               	addb	%ah, %dh
               	andb	%al, (%rax)
               	addb	%ch, %bl
               	andb	%al, (%rax)
               	addb	%dh, %al
               	andb	%al, (%rax)
               	addb	%dh, %ch
               	andb	%al, (%rax)
               	addb	%bh, %dl
               	andb	%al, (%rax)
               	addb	%bh, %bh
               	andb	%al, (%rax)
               	addb	%al, (%rcx,%riz)
               	addb	%al, (%rax)
               	orl	%esp, (%rcx)
               	addb	%al, (%rax)
               	<unknown>
               	andl	%eax, (%rax)
               	addb	%dl, (%rbx)
               	andl	%eax, (%rax)
               	addb	%bl, (%rax)
               	andl	%eax, (%rax)
               	addb	%bl, <rip>
               	andl	%eax, (%rax)
               	addb	%ah, (%rdi)
               	andl	%eax, (%rax)
               	addb	%ch, (%rcx,%riz)
               	addb	%al, (%rax)
               	xorl	%esp, (%rcx)
               	addb	%al, (%rax)
               	andl	%eax, %ss:(%rax)
               	addb	%bh, (%rbx)
               	andl	%eax, (%rax)
               	addb	%al, 0x21(%rax)
               	addb	%al, (%rax)
               	andl	%r8d, (%r8)
               	addb	%cl, 0x21(%rdx)
               	addb	%al, (%rax)
               	andq	%r8, (%r8)
               	addb	%dl, (%rcx,%riz)
               	addb	%bl, 0x21(%rcx)
               	addb	%al, (%rax)
               	popq	%rsi
               	andl	%eax, (%rax)
               	addb	%ah, 0x21(%rbx)
               	addb	%al, (%rax)
               	pushq	$0x6d000021             # imm = 0x6D000021
               	andl	%eax, (%rax)
               	addb	%dh, 0x21(%rdx)
               	addb	%al, (%rax)
               	ja	<addr>
               	addb	%al, (%rax)
               	jl	<addr>
               	addb	%al, (%rax)
               	andl	$0x21860000, (%rcx)     # imm = 0x21860000
               	addb	%al, (%rax)
               	movl	(%rcx), %esp
               	addb	%al, (%rax)
               	nop
               	andl	%eax, (%rax)
               	addb	%dl, -0x65ffffdf(%rbp)
               	andl	%eax, (%rax)
               	addb	%bl, -0x5bffffdf(%rdi)
               	andl	%eax, (%rax)
               	addb	%ch, -0x51ffffdf(%rcx)
               	andl	%eax, (%rax)
               	addb	%dh, -0x47ffffdf(%rbx)
               	andl	%eax, (%rax)
               	addb	%bh, -0x3dffffdf(%rbp)
               	andl	%eax, (%rax)
               	addb	%al, %bh
               	andl	%eax, (%rax)
               	addb	%cl, %ah
               	andl	%eax, (%rax)
               	addb	%dl, %cl
               	andl	%eax, (%rax)
               	addb	%dl, %dh
               	andl	%eax, (%rax)
               	addb	%bl, %bl
               	andl	%eax, (%rax)
               	addb	%ah, %al
               	andl	%eax, (%rax)
               	addb	%ah, %ch
               	andl	%eax, (%rax)
               	addb	%ch, %dl
               	andl	%eax, (%rax)
               	addb	%ch, %bh
               	andl	%eax, (%rax)
               	addb	%dh, %ah
               	andl	%eax, (%rax)
               	addb	%bh, %cl
               	andl	%eax, (%rax)
               	addb	%bh, %dh
               	andl	%eax, (%rax)
               	addb	%al, (%rbx)
               	andb	(%rax), %al
               	addb	%cl, (%rax)
               	andb	(%rax), %al
               	addb	%cl, <rip>
               	andb	(%rax), %al
               	addb	%dl, (%rdi)
               	andb	(%rax), %al
               	addb	%bl, (%rdx,%riz)
               	addb	%al, (%rax)
               	andl	%esp, (%rdx)
               	addb	%al, (%rax)
               	andb	%es:(%rax), %al
               	addb	%ch, (%rbx)
               	andb	(%rax), %al
               	addb	%dh, (%rax)
               	andb	(%rax), %al
               	addb	%dh, <rip>
               	andb	(%rax), %al
               	addb	%bh, (%rdi)
               	andb	(%rax), %al
               	addb	%al, (%rdx,%riz)
               	addb	%cl, 0x22(%rcx)
               	addb	%al, (%rax)
               	andb	(%rax), %r8b
               	addb	%dl, 0x22(%rbx)
               	addb	%al, (%rax)
               	popq	%rax
               	andb	(%rax), %al
               	addb	%bl, 0x22(%rbp)
               	addb	%al, (%rax)
               	<unknown>
               	andb	(%rax), %al
               	addb	%ch, (%rdx,%riz)
               	addb	%dh, 0x22(%rcx)
               	addb	%al, (%rax)
               	jbe	<addr>
               	addb	%al, (%rax)
               	jnp	<addr>
               	addb	%al, (%rax)
               	andb	$0x0, (%rdx)
               	addb	%al, -0x75ffffde(%rbp)
               	andb	(%rax), %al
               	addb	%cl, -0x6bffffde(%rdi)
               	andb	(%rax), %al
               	addb	%bl, -0x61ffffde(%rcx)
               	andb	(%rax), %al
               	addb	%ah, -0x57ffffde(%rbx)
               	andb	(%rax), %al
               	addb	%ch, -0x4dffffde(%rbp)
               	andb	(%rax), %al
               	addb	%dh, -0x43ffffde(%rdi)
               	andb	(%rax), %al
               	addb	%al, %cl
               	andb	(%rax), %al
               	addb	%al, %dh
               	andb	(%rax), %al
               	addb	%cl, %bl
               	andb	(%rax), %al
               	addb	%dl, %al
               	andb	(%rax), %al
               	addb	%dl, %ch
               	andb	(%rax), %al
               	addb	%bl, %dl
               	andb	(%rax), %al
               	addb	%bl, %bh
               	andb	(%rax), %al
               	addb	%ah, %ah
               	andb	(%rax), %al
               	addb	%ch, %cl
               	andb	(%rax), %al
               	addb	%ch, %dh
               	andb	(%rax), %al
               	addb	%dh, %bl
               	andb	(%rax), %al
               	addb	%bh, %al
               	andb	(%rax), %al
               	addb	%bh, %ch
               	andb	(%rax), %al
               	addb	%al, (%rdx)
               	andl	(%rax), %eax
               	addb	%al, (%rdi)
               	andl	(%rax), %eax
               	addb	%cl, (%rbx,%riz)
               	addb	%al, (%rax)
               	adcl	%esp, (%rbx)
               	addb	%al, (%rax)
               	<unknown>
               	andl	(%rax), %eax
               	addb	%bl, (%rbx)
               	andl	(%rax), %eax
               	addb	%ah, (%rax)
               	andl	(%rax), %eax
               	addb	%ah, <rip>
               	andl	(%rax), %eax
               	addb	%ch, (%rdi)
               	andl	(%rax), %eax
               	addb	%dh, (%rbx,%riz)
               	addb	%al, (%rax)
               	cmpl	%esp, (%rbx)
               	addb	%al, (%rax)
               	andl	%ds:(%rax), %eax
               	addb	%al, 0x23(%rbx)
               	addb	%al, (%rax)
               	andq	(%rax), %rax
               	addb	%cl, 0x23(%rbp)
               	addb	%al, (%rax)
               	pushq	%rdx
               	andl	(%rax), %eax
               	addb	%dl, 0x23(%rdi)
               	addb	%al, (%rax)
               	popq	%rsp
               	andl	(%rax), %eax
               	addb	%ah, 0x23(%rcx)
               	addb	%al, (%rax)
               	andw	(%rax), %ax
               	addb	%ch, 0x23(%rbx)
               	addb	%al, (%rax)
               	jo	<addr>
               	addb	%al, (%rax)
               	jne	<addr>
               	addb	%al, (%rax)
               	jp	<addr>
               	addb	%al, (%rax)
               	jg	<addr>
               	addb	%al, (%rax)
               	testb	%ah, (%rbx)
               	addb	%al, (%rax)
               	movl	%esp, (%rbx)
               	addb	%al, (%rax)
               	movw	(%rbx), %fs
               	addb	%al, (%rax)
               	xchgl	%ebx, %eax
               	andl	(%rax), %eax
               	addb	%bl, -0x62ffffdd(%rax)
               	andl	(%rax), %eax
               	addb	%ah, -0x58ffffdd(%rdx)
               	andl	(%rax), %eax
               	addb	%ch, 0x23b10000(%rbx,%riz)
               	addb	%al, (%rax)
               	movb	$0x23, %dh
               	addb	%al, (%rax)
               	movl	$0xc0000023, %ebx       # imm = 0xC0000023
               	andl	(%rax), %eax
               	addb	%al, %ch
               	andl	(%rax), %eax
               	addb	%cl, %dl
               	andl	(%rax), %eax
               	addb	%cl, %bh
               	andl	(%rax), %eax
               	addb	%dl, %ah
               	andl	(%rax), %eax
               	addb	%bl, %cl
               	andl	(%rax), %eax
               	addb	%bl, %dh
               	andl	(%rax), %eax
               	addb	%ah, %bl
               	andl	(%rax), %eax
               	addb	%ch, %al
               	andl	(%rax), %eax
               	addb	%ch, %ch
               	andl	(%rax), %eax
               	addb	%dh, %dl
               	andl	(%rax), %eax
               	addb	%dh, %bh
               	andl	(%rax), %eax
               	addb	%bh, %ah
               	andl	(%rax), %eax
               	addb	%al, (%rcx)
               	andb	$0x0, %al
               	addb	%al, (%rsi)
               	andb	$0x0, %al
               	addb	%cl, (%rbx)
               	andb	$0x0, %al
               	addb	%dl, (%rax)
               	andb	$0x0, %al
               	addb	%dl, <rip>
               	andb	$0x0, %al
               	addb	%bl, (%rdi)
               	andb	$0x0, %al
               	addb	%ah, (%rsp)
               	addb	%al, (%rax)
               	subl	%esp, (%rax,%rax)
               	addb	%ch, (%rsi)
               	andb	$0x0, %al
               	addb	%dh, (%rbx)
               	andb	$0x0, %al
               	addb	%bh, (%rax)
               	andb	$0x0, %al
               	addb	%bh, <rip>
               	andb	$0x0, %al
               	addb	%al, 0x24(%rdi)
               	addb	%al, (%rax)
               	andb	$0x0, %al
               	addb	%dl, 0x24(%rcx)
               	addb	%al, (%rax)
               	pushq	%rsi
               	andb	$0x0, %al
               	addb	%bl, 0x24(%rbx)
               	addb	%al, (%rax)
               	<unknown>
               	andb	$0x0, %al
               	addb	%ah, 0x24(%rbp)
               	addb	%al, (%rax)
               	pushq	$0x24
               	addb	%al, (%rax)
               	outsl	(%rsi), %dx
               	andb	$0x0, %al
               	addb	%dh, (%rsp)
               	addb	%bh, 0x24(%rcx)
               	addb	%al, (%rax)
               	jle	<addr>
               	addb	%al, (%rax)
               	andl	$0x0, (%rax,%rax)
               	movb	%ah, (%rax,%rax)
               	addb	%cl, -0x6dffffdc(%rbp)
               	andb	$0x0, %al
               	addb	%dl, -0x63ffffdc(%rdi)
               	andb	$0x0, %al
               	addb	%ah, -0x59ffffdc(%rcx)
               	andb	$0x0, %al
               	addb	%ch, -0x4fffffdc(%rbx)
               	andb	$0x0, %al
               	addb	%dh, -0x45ffffdc(%rbp)
               	andb	$0x0, %al
               	addb	%bh, -0x3bffffdc(%rdi)
               	andb	$0x0, %al
               	addb	%cl, %cl
               	andb	$0x0, %al
               	addb	%cl, %dh
               	andb	$0x0, %al
               	addb	%dl, %bl
               	andb	$0x0, %al
               	addb	%bl, %al
               	andb	$0x0, %al
               	addb	%bl, %ch
               	andb	$0x0, %al
               	addb	%ah, %dl
               	andb	$0x0, %al
               	addb	%ah, %bh
               	andb	$0x0, %al
               	addb	%ch, %ah
               	andb	$0x0, %al
               	addb	%dh, %cl
               	andb	$0x0, %al
               	addb	%dh, %dh
               	andb	$0x0, %al
               	addb	%bh, %bl
               	andb	$0x0, %al
               	addb	%al, (%rax)
               	andl	$0x25050000, %eax       # imm = 0x25050000
               	addb	%al, (%rax)
               	orb	<rip>, %ah
               	addb	%al, (%rax)
               	adcb	$0x25, %al
               	addb	%al, (%rax)
               	sbbl	%esp, <rip>
               	addb	%al, (%rax)
               	andl	<rip>, %esp
               	addb	%al, (%rax)
               	subl	$0x32000025, %eax       # imm = 0x32000025
               	andl	$0x25370000, %eax       # imm = 0x25370000
               	addb	%al, (%rax)
               	cmpb	$0x25, %al
               	addb	%al, (%rax)
               	andl	$0x25460000, %eax       # imm = 0x25460000
               	addb	%al, (%rax)
               	andq	$0x25500000, %rax       # imm = 0x25500000
               	addb	%al, (%rax)
               	pushq	%rbp
               	andl	$0x255a0000, %eax       # imm = 0x255A0000
               	addb	%al, (%rax)
               	popq	%rdi
               	andl	$0x25640000, %eax       # imm = 0x25640000
               	addb	%al, (%rax)
               	imull	$0x25730000, <rip>, %esp # imm = 0x25730000
               	addb	%al, (%rax)
               	js	<addr>
               	addb	%al, (%rax)
               	jge	<addr>
               	addb	%al, (%rax)
               	<unknown>
               	andl	$0x25870000, %eax       # imm = 0x25870000
               	addb	%al, (%rax)
               	movw	%fs, <rip>
               	addb	%al, (%rax)
               	xchgl	%esi, %eax
               	andl	$0x259b0000, %eax       # imm = 0x259B0000
               	addb	%al, (%rax)
               	movabsb	-0x55ffffda5affffdb, %al
               	andl	$0x25af0000, %eax       # imm = 0x25AF0000
               	addb	%al, (%rax)
               	movb	$0x25, %ah
               	addb	%al, (%rax)
               	movl	$0xbe000025, %ecx       # imm = 0xBE000025
               	andl	$0x25c30000, %eax       # imm = 0x25C30000
               	addb	%al, (%rax)
               	enter	$0x25, $0x0
               	int	$0x25
               	addb	%al, (%rax)
               	shlb	%cl, <rip>
               	addb	%al, (%rax)
               	fsubl	<rip>
               	addb	%al, (%rax)
               	outb	%al, $0x25
               	addb	%al, (%rax)
               	jmp	<addr>
               	addb	%al, (%rax)
               	lock
               	andl	$0x25f50000, %eax       # imm = 0x25F50000
               	addb	%al, (%rax)
               	cli
               	andl	$0x25ff0000, %eax       # imm = 0x25FF0000
               	addb	%al, (%rax)
               	addb	$0x26, %al
               	addb	%al, (%rax)
               	orl	%esp, (%rsi)
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, %es:(%rax)
               	adcl	(%rsi), %esp
               	addb	%al, (%rax)
               	sbbb	%ah, (%rsi)
               	addb	%al, (%rax)
               	sbbl	$0x22000026, %eax       # imm = 0x22000026
               	addb	%al, %es:(%rax)
               	<unknown>
               	addb	%al, %es:(%rax)
               	subb	$0x26, %al
               	addb	%al, (%rax)
               	xorl	%esp, (%rsi)
               	addb	%al, (%rax)
               	addb	%al, %es:(%rax)
               	cmpl	(%rsi), %esp
               	addb	%al, (%rax)
               	addb	%al, %es:(%rax)
               	addb	%al, %es:(%rax)
               	addb	%al, %es:(%rax)
               	addb	%al, %es:(%rax)
               	pushq	%rsp
               	addb	%al, %es:(%rax)
               	popq	%rcx
               	addb	%al, %es:(%rax)
               	popq	%rsi
               	addb	%al, %es:(%rax)
               	movslq	(%rsi), %esp
               	addb	%al, (%rax)
               	pushq	$0x6d000026             # imm = 0x6D000026
               	addb	%al, %es:(%rax)
               	jb	<addr>
               	addb	%al, (%rax)
               	ja	<addr>
               	addb	%al, (%rax)
               	jl	<addr>
               	addb	%al, (%rax)
               	andl	$0x26860000, (%rsi)     # imm = 0x26860000
               	addb	%al, (%rax)
               	movl	(%rsi), %esp
               	addb	%al, (%rax)
               	nop
               	addb	%al, %es:(%rax)
               	xchgl	%ebp, %eax
               	addb	%al, %es:(%rax)
               	<unknown>
               	addb	%al, %es:(%rax)
               	lahf
               	addb	%al, %es:(%rax)
               	movsb	(%rsi), %es:(%rdi)
               	addb	%al, %es:(%rax)
               	testl	$0xae000026, %eax       # imm = 0xAE000026
               	addb	%al, %es:(%rax)
               	movb	$0x26, %bl
               	addb	%al, (%rax)
               	movl	$0xbd000026, %eax       # imm = 0xBD000026
               	addb	%al, %es:(%rax)
               	retq	$0x26
               	addb	%al, %bh
               	addb	%al, %es:(%rax)
               	int3
               	addb	%al, %es:(%rax)
               	shll	(%rsi)
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, %es:(%rax)
               	<unknown>
               	addb	%al, (%rax)
               	loopne	<addr>
               	addb	%al, (%rax)
               	inl	$0x26, %eax
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, %es:(%rax)
               	outl	%eax, %dx
               	addb	%al, %es:(%rax)
               	hlt
               	addb	%al, %es:(%rax)
               	stc
               	addb	%al, %es:(%rax)
               	<unknown>
               	addb	%al, (%rax)
               	addl	(%rdi), %esp
               	addb	%al, (%rax)
               	orb	%ah, (%rdi)
               	addb	%al, (%rax)
               	orl	$0x12000027, %eax       # imm = 0x12000027
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	sbbb	$0x27, %al
               	addb	%al, (%rax)
               	andl	%esp, (%rdi)
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	subl	(%rdi), %esp
               	addb	%al, (%rax)
               	xorb	%ah, (%rdi)
               	addb	%al, (%rax)
               	xorl	$0x3a000027, %eax       # imm = 0x3A000027
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	pushq	%rbx
               	<unknown>
               	addb	%al, (%rax)
               	popq	%rax
               	<unknown>
               	addb	%al, (%rax)
               	popq	%rbp
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	insb	%dx, %es:(%rdi)
               	<unknown>
               	addb	%al, (%rax)
               	jno	<addr>
               	addb	%al, (%rax)
               	jbe	<addr>
               	addb	%al, (%rax)
               	jnp	<addr>
               	addb	%al, (%rax)
               	andb	$0x0, (%rdi)
               	addb	%al, -0x75ffffd9(%rbp)
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%dl, 0x27990000(%rdi,%riz)
               	addb	%al, (%rax)
               	sahf
               	<unknown>
               	addb	%al, (%rax)
               	movabsl	%eax, -0x52ffffd857ffffd9
               	<unknown>
               	addb	%al, (%rax)
               	movb	$0x27, %dl
               	addb	%al, (%rax)
               	movb	$0x27, %bh
               	addb	%al, (%rax)
               	movl	$0xc1000027, %esp       # imm = 0xC1000027
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	lretl
               	<unknown>
               	addb	%al, (%rax)
               	shlb	(%rdi)
               	addb	%al, (%rax)
               	addb	%r8b, (%r8)
               	fisubl	(%rdi)
               	addb	%al, (%rax)
               	fbld	(%rdi)
               	addb	%al, (%rax)
               	inb	$0x27, %al
               	addb	%al, (%rax)
               	jmp	0xffffffffee400a4a
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	clc
               	<unknown>
               	addb	%al, (%rax)
               	std
               	<unknown>
               	addb	%al, (%rax)
               	addb	(%rax), %ch
               	addb	%al, (%rax)
               	<unknown>
               	subb	%al, (%rax)
               	addb	%cl, (%rax,%rbp)
               	addb	%al, (%rax)
               	adcl	%ebp, (%rax)
               	addb	%al, (%rax)
               	<unknown>
               	subb	%al, (%rax)
               	addb	%bl, (%rbx)
               	subb	%al, (%rax)
               	addb	%ah, (%rax)
               	subb	%al, (%rax)
               	addb	%ah, <rip>
               	subb	%al, (%rax)
               	addb	%ch, (%rdi)
               	subb	%al, (%rax)
               	addb	%dh, (%rax,%rbp)
               	addb	%al, (%rax)
               	cmpl	%ebp, (%rax)
               	addb	%al, (%rax)
               	subb	%al, %ds:(%rax)
               	addb	%al, 0x28(%rbx)
               	addb	%al, (%rax)
               	subb	%al, (%rax)
               	addb	%cl, 0x28(%rbp)
               	addb	%al, (%rax)
               	pushq	%rdx
               	subb	%al, (%rax)
               	addb	%dl, 0x28(%rdi)
               	addb	%al, (%rax)
               	popq	%rsp
               	subb	%al, (%rax)
               	addb	%ah, 0x28(%rcx)
               	addb	%al, (%rax)
               	subb	%al, (%rax)
               	addb	%ch, 0x28(%rbx)
               	addb	%al, (%rax)
               	jo	<addr>
               	addb	%al, (%rax)
               	jne	<addr>
               	addb	%al, (%rax)
               	jp	<addr>
               	addb	%al, (%rax)
               	jg	<addr>
               	addb	%al, (%rax)
               	testb	%ch, (%rax)
               	addb	%al, (%rax)
               	movl	%ebp, (%rax)
               	addb	%al, (%rax)
               	movw	(%rax), %gs
               	addb	%al, (%rax)
               	xchgl	%ebx, %eax
               	subb	%al, (%rax)
               	addb	%bl, -0x62ffffd8(%rax)
               	subb	%al, (%rax)
               	addb	%ah, -0x58ffffd8(%rdx)
               	subb	%al, (%rax)
               	addb	%ch, 0x28b10000(%rax,%rbp)
               	addb	%al, (%rax)
               	movb	$0x28, %dh
               	addb	%al, (%rax)
               	movl	$0xc0000028, %ebx       # imm = 0xC0000028
               	subb	%al, (%rax)
               	addb	%al, %ch
               	subb	%al, (%rax)
               	addb	%cl, %dl
               	subb	%al, (%rax)
               	addb	%cl, %bh
               	subb	%al, (%rax)
               	addb	%dl, %ah
               	subb	%al, (%rax)
               	addb	%bl, %cl
               	subb	%al, (%rax)
               	addb	%bl, %dh
               	subb	%al, (%rax)
               	addb	%ah, %bl
               	subb	%al, (%rax)
               	addb	%ch, %al
               	subb	%al, (%rax)
               	addb	%ch, %ch
               	subb	%al, (%rax)
               	addb	%dh, %dl
               	subb	%al, (%rax)
               	addb	%dh, %bh
               	subb	%al, (%rax)
               	addb	%bh, %ah
               	subb	%al, (%rax)
               	addb	%al, (%rcx)
               	subl	%eax, (%rax)
               	addb	%al, (%rsi)
               	subl	%eax, (%rax)
               	addb	%cl, (%rbx)
               	subl	%eax, (%rax)
               	addb	%dl, (%rax)
               	subl	%eax, (%rax)
               	addb	%dl, <rip>
               	subl	%eax, (%rax)
               	addb	%bl, (%rdi)
               	subl	%eax, (%rax)
               	addb	%ah, (%rcx,%rbp)
               	addb	%al, (%rax)
               	subl	%ebp, (%rcx)
               	addb	%al, (%rax)
               	subl	%eax, %cs:(%rax)
               	addb	%dh, (%rbx)
               	subl	%eax, (%rax)
               	addb	%bh, (%rax)
               	subl	%eax, (%rax)
               	addb	%bh, <rip>
               	subl	%eax, (%rax)
               	addb	%al, 0x29(%rdi)
               	addb	%al, (%rax)
               	subq	%r8, (%rax)
               	addb	%dl, 0x29(%rcx)
               	addb	%al, (%rax)
               	pushq	%rsi
               	subl	%eax, (%rax)
               	addb	%bl, 0x29(%rbx)
               	addb	%al, (%rax)
               	<unknown>
               	subl	%eax, (%rax)
               	addb	%ah, 0x29(%rbp)
               	addb	%al, (%rax)
               	pushq	$0x29
               	addb	%al, (%rax)
               	outsl	(%rsi), %dx
               	subl	%eax, (%rax)
               	addb	%dh, (%rcx,%rbp)
               	addb	%bh, 0x29(%rcx)
               	addb	%al, (%rax)
               	jle	<addr>
               	addb	%al, (%rax)
               	subl	$0x0, (%rcx)
               	addb	%cl, -0x72ffffd7(%rax)
               	subl	%eax, (%rax)
               	addb	%dl, -0x68ffffd7(%rdx)
               	subl	%eax, (%rax)
               	addb	%bl, 0x29a10000(%rcx,%rbp)
               	addb	%al, (%rax)
               	cmpsb	%es:(%rdi), (%rsi)
               	subl	%eax, (%rax)
               	addb	%ch, -0x4fffffd7(%rbx)
               	subl	%eax, (%rax)
               	addb	%dh, -0x45ffffd7(%rbp)
               	subl	%eax, (%rax)
               	addb	%bh, -0x3bffffd7(%rdi)
               	subl	%eax, (%rax)
               	addb	%cl, %cl
               	subl	%eax, (%rax)
               	addb	%cl, %dh
               	subl	%eax, (%rax)
               	addb	%dl, %bl
               	subl	%eax, (%rax)
               	addb	%bl, %al
               	subl	%eax, (%rax)
               	addb	%bl, %ch
               	subl	%eax, (%rax)
               	addb	%ah, %dl
               	subl	%eax, (%rax)
               	addb	%ah, %bh
               	subl	%eax, (%rax)
               	addb	%ch, %ah
               	subl	%eax, (%rax)
               	addb	%dh, %cl
               	subl	%eax, (%rax)
               	addb	%dh, %dh
               	subl	%eax, (%rax)
               	addb	%bh, %bl
               	subl	%eax, (%rax)
               	addb	%al, (%rax)
               	subb	(%rax), %al
               	addb	%al, <rip>
               	subb	(%rax), %al
               	addb	%cl, (%rdi)
               	subb	(%rax), %al
               	addb	%dl, (%rdx,%rbp)
               	addb	%al, (%rax)
               	sbbl	%ebp, (%rdx)
               	addb	%al, (%rax)
               	<unknown>
               	subb	(%rax), %al
               	addb	%ah, (%rbx)
               	subb	(%rax), %al
               	addb	%ch, (%rax)
               	subb	(%rax), %al
               	addb	%ch, <rip>
               	subb	(%rax), %al
               	addb	%dh, (%rdi)
               	subb	(%rax), %al
               	addb	%bh, (%rdx,%rbp)
               	addb	%al, (%rax)
               	subb	(%r8), %al
               	addb	%al, 0x2a(%rsi)
               	addb	%al, (%rax)
               	subb	(%r8), %al
               	addb	%dl, 0x2a(%rax)
               	addb	%al, (%rax)
               	pushq	%rbp
               	subb	(%rax), %al
               	addb	%bl, 0x2a(%rdx)
               	addb	%al, (%rax)
               	popq	%rdi
               	subb	(%rax), %al
               	addb	%ah, (%rdx,%rbp)
               	addb	%ch, 0x2a(%rcx)
               	addb	%al, (%rax)
               	outsb	(%rsi), %dx
               	subb	(%rax), %al
               	addb	%dh, 0x2a(%rbx)
               	addb	%al, (%rax)
               	js	<addr>
               	addb	%al, (%rax)
               	jge	<addr>
               	addb	%al, (%rax)
               	<unknown>
               	subb	(%rax), %al
               	addb	%al, -0x73ffffd6(%rdi)
               	subb	(%rax), %al
               	addb	%dl, -0x69ffffd6(%rcx)
               	subb	(%rax), %al
               	addb	%bl, -0x5fffffd6(%rbx)
               	subb	(%rax), %al
               	addb	%ah, -0x55ffffd6(%rbp)
               	subb	(%rax), %al
               	addb	%ch, -0x4bffffd6(%rdi)
               	subb	(%rax), %al
               	addb	%bh, -0x41ffffd6(%rcx)
               	subb	(%rax), %al
               	addb	%al, %bl
               	subb	(%rax), %al
               	addb	%cl, %al
               	subb	(%rax), %al
               	addb	%cl, %ch
               	subb	(%rax), %al
               	addb	%dl, %dl
               	subb	(%rax), %al
               	addb	%dl, %bh
               	subb	(%rax), %al
               	addb	%bl, %ah
               	subb	(%rax), %al
               	addb	%ah, %cl
               	subb	(%rax), %al
               	addb	%ah, %dh
               	subb	(%rax), %al
               	addb	%ch, %bl
               	subb	(%rax), %al
               	addb	%dh, %al
               	subb	(%rax), %al
               	addb	%dh, %ch
               	subb	(%rax), %al
               	addb	%bh, %dl
               	subb	(%rax), %al
               	addb	%bh, %bh
               	subb	(%rax), %al
               	addb	%al, (%rbx,%rbp)
               	addb	%al, (%rax)
               	orl	%ebp, (%rbx)
               	addb	%al, (%rax)
               	<unknown>
               	subl	(%rax), %eax
               	addb	%dl, (%rbx)
               	subl	(%rax), %eax
               	addb	%bl, (%rax)
               	subl	(%rax), %eax
               	addb	%bl, <rip>
               	subl	(%rax), %eax
               	addb	%ah, (%rdi)
               	subl	(%rax), %eax
               	addb	%ch, (%rbx,%rbp)
               	addb	%al, (%rax)
               	xorl	%ebp, (%rbx)
               	addb	%al, (%rax)
               	subl	%ss:(%rax), %eax
               	addb	%bh, (%rbx)
               	subl	(%rax), %eax
               	addb	%al, 0x2b(%rax)
               	addb	%al, (%rax)
               	subl	(%r8), %r8d
               	addb	%cl, 0x2b(%rdx)
               	addb	%al, (%rax)
               	subq	(%r8), %r8
               	addb	%dl, (%rbx,%rbp)
               	addb	%bl, 0x2b(%rcx)
               	addb	%al, (%rax)
               	popq	%rsi
               	subl	(%rax), %eax
               	addb	%ah, 0x2b(%rbx)
               	addb	%al, (%rax)
               	pushq	$0x6d00002b             # imm = 0x6D00002B
               	subl	(%rax), %eax
               	addb	%dh, 0x2b(%rdx)
               	addb	%al, (%rax)
               	ja	<addr>
               	addb	%al, (%rax)
               	jl	<addr>
               	addb	%al, (%rax)
               	subl	$0x2b860000, (%rbx)     # imm = 0x2B860000
               	addb	%al, (%rax)
               	movl	(%rbx), %ebp
               	addb	%al, (%rax)
               	nop
               	subl	(%rax), %eax
               	addb	%dl, -0x65ffffd5(%rbp)
               	subl	(%rax), %eax
               	addb	%bl, -0x5bffffd5(%rdi)
               	subl	(%rax), %eax
               	addb	%ch, -0x51ffffd5(%rcx)
               	subl	(%rax), %eax
               	addb	%dh, -0x47ffffd5(%rbx)
               	subl	(%rax), %eax
               	addb	%bh, -0x3dffffd5(%rbp)
               	subl	(%rax), %eax
               	addb	%al, %bh
               	subl	(%rax), %eax
               	addb	%cl, %ah
               	subl	(%rax), %eax
               	addb	%dl, %cl
               	subl	(%rax), %eax
               	addb	%dl, %dh
               	subl	(%rax), %eax
               	addb	%bl, %bl
               	subl	(%rax), %eax
               	addb	%ah, %al
               	subl	(%rax), %eax
               	addb	%ah, %ch
               	subl	(%rax), %eax
               	addb	%ch, %dl
               	subl	(%rax), %eax
               	addb	%ch, %bh
               	subl	(%rax), %eax
               	addb	%dh, %ah
               	subl	(%rax), %eax
               	addb	%bh, %cl
               	subl	(%rax), %eax
               	addb	%bh, %dh
               	subl	(%rax), %eax
               	addb	%al, (%rbx)
               	subb	$0x0, %al
               	addb	%cl, (%rax)
               	subb	$0x0, %al
               	addb	%cl, <rip>
               	subb	$0x0, %al
               	addb	%dl, (%rdi)
               	subb	$0x0, %al
               	addb	%bl, (%rsp,%rbp)
               	addb	%al, (%rax)
               	andl	%ebp, (%rax,%rax)
               	addb	%ah, (%rsi)
               	subb	$0x0, %al
               	addb	%ch, (%rbx)
               	subb	$0x0, %al
               	addb	%dh, (%rax)
               	subb	$0x0, %al
               	addb	%dh, <rip>
               	subb	$0x0, %al
               	addb	%bh, (%rdi)
               	subb	$0x0, %al
               	addb	%al, (%rsp,%rbp)
               	addb	%cl, 0x2c(%rcx)
               	addb	%al, (%rax)
               	subb	$0x0, %al
               	addb	%dl, 0x2c(%rbx)
               	addb	%al, (%rax)
               	popq	%rax
               	subb	$0x0, %al
               	addb	%bl, 0x2c(%rbp)
               	addb	%al, (%rax)
               	<unknown>
               	subb	$0x0, %al
               	addb	%ch, (%rsp,%rbp)
               	addb	%dh, 0x2c(%rcx)
               	addb	%al, (%rax)
               	jbe	<addr>
               	addb	%al, (%rax)
               	jnp	<addr>
               	addb	%al, (%rax)
               	subb	$0x0, (%rax,%rax)
               	testl	%ebp, (%rax,%rax)
               	addb	%cl, -0x70ffffd4(%rdx)
               	subb	$0x0, %al
               	addb	%dl, 0x2c990000(%rsp,%rbp)
               	addb	%al, (%rax)
               	sahf
               	subb	$0x0, %al
               	addb	%ah, -0x57ffffd4(%rbx)
               	subb	$0x0, %al
               	addb	%ch, -0x4dffffd4(%rbp)
               	subb	$0x0, %al
               	addb	%dh, -0x43ffffd4(%rdi)
               	subb	$0x0, %al
               	addb	%al, %cl
               	subb	$0x0, %al
               	addb	%al, %dh
               	subb	$0x0, %al
               	addb	%cl, %bl
               	subb	$0x0, %al
               	addb	%dl, %al
               	subb	$0x0, %al
               	addb	%dl, %ch
               	subb	$0x0, %al
               	addb	%bl, %dl
               	subb	$0x0, %al
               	addb	%bl, %bh
               	subb	$0x0, %al
               	addb	%ah, %ah
               	subb	$0x0, %al
               	addb	%ch, %cl
               	subb	$0x0, %al
               	addb	%ch, %dh
               	subb	$0x0, %al
               	addb	%dh, %bl
               	subb	$0x0, %al
               	addb	%bh, %al
               	subb	$0x0, %al
               	addb	%bh, %ch
               	subb	$0x0, %al
               	addb	%al, (%rdx)
               	subl	$0x2d070000, %eax       # imm = 0x2D070000
               	addb	%al, (%rax)
               	orb	$0x2d, %al
               	addb	%al, (%rax)
               	adcl	%ebp, <rip>
               	addb	%al, (%rax)
               	sbbl	<rip>, %ebp
               	addb	%al, (%rax)
               	andl	$0x2a00002d, %eax       # imm = 0x2A00002D
               	subl	$0x2d2f0000, %eax       # imm = 0x2D2F0000
               	addb	%al, (%rax)
               	xorb	$0x2d, %al
               	addb	%al, (%rax)
               	cmpl	%ebp, <rip>
               	addb	%al, (%rax)
               	subl	$0x2d480000, %eax       # imm = 0x2D480000
               	addb	%al, (%rax)
               	subq	$0x2d520000, %rax       # imm = 0x2D520000
               	addb	%al, (%rax)
               	pushq	%rdi
               	subl	$0x2d5c0000, %eax       # imm = 0x2D5C0000
               	addb	%al, (%rax)
               	<unknown>
               	subl	$0x2d660000, %eax       # imm = 0x2D660000
               	addb	%al, (%rax)
               	imull	$0x0, <rip>, %ebp
               	addb	%dh, 0x2d(%rbp)
               	addb	%al, (%rax)
               	jp	<addr>
               	addb	%al, (%rax)
               	jg	<addr>
               	addb	%al, (%rax)
               	testb	%ch, <rip>
               	addb	%al, (%rax)
               	movw	<rip>, %gs
               	addb	%al, (%rax)
               	cwtl
               	subl	$0x2d9d0000, %eax       # imm = 0x2D9D0000
               	addb	%al, (%rax)
               	movabsb	%al, -0x53ffffd258ffffd3
               	subl	$0x2db10000, %eax       # imm = 0x2DB10000
               	addb	%al, (%rax)
               	movb	$0x2d, %dh
               	addb	%al, (%rax)
               	movl	$0xc000002d, %ebx       # imm = 0xC000002D
               	subl	$0x2dc50000, %eax       # imm = 0x2DC50000
               	addb	%al, (%rax)
               	lretl	$0x2d
               	addb	%cl, %bh
               	subl	$0x2dd40000, %eax       # imm = 0x2DD40000
               	addb	%al, (%rax)
               	fldcw	<rip>
               	addb	%al, (%rax)
               	jrcxz	<addr>
               	addb	%al, (%rax)
               	callq	0xffffffffed400f1c
               	subl	$0x2df20000, %eax       # imm = 0x2DF20000
               	addb	%al, (%rax)
               	imull	<rip>
               	addb	%al, (%rax)
               	addl	%ebp, (%rsi)
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, %cs:(%rax)
               	orl	(%rsi), %ebp
               	addb	%al, (%rax)
               	adcb	%ch, (%rsi)
               	addb	%al, (%rax)
               	adcl	$0x1a00002e, %eax       # imm = 0x1A00002E
               	addb	%al, %cs:(%rax)
               	<unknown>
               	addb	%al, %cs:(%rax)
               	andb	$0x2e, %al
               	addb	%al, (%rax)
               	subl	%ebp, (%rsi)
               	addb	%al, (%rax)
               	addb	%al, %cs:(%rax)
               	xorl	(%rsi), %ebp
               	addb	%al, (%rax)
               	cmpb	%ch, (%rsi)
               	addb	%al, (%rax)
               	cmpl	$0x4200002e, %eax       # imm = 0x4200002E
               	addb	%al, %cs:(%rax)
               	addb	%al, %cs:(%rax)
               	addb	%al, %cs:(%rax)
               	pushq	%rcx
               	addb	%al, %cs:(%rax)
               	pushq	%rsi
               	addb	%al, %cs:(%rax)
               	popq	%rbx
               	addb	%al, %cs:(%rax)
               	<unknown>
               	addb	%al, %cs:(%rax)
               	addb	%al, %cs:(%rax)
               	pushq	$0x2e
               	addb	%al, (%rax)
               	outsl	(%rsi), %dx
               	addb	%al, %cs:(%rax)
               	je	<addr>
               	addb	%al, (%rax)
               	jns	<addr>
               	addb	%al, (%rax)
               	jle	<addr>
               	addb	%al, (%rax)
               	subl	$0x0, (%rsi)
               	addb	%cl, -0x72ffffd2(%rax)
               	addb	%al, %cs:(%rax)
               	xchgl	%edx, %eax
               	addb	%al, %cs:(%rax)
               	xchgl	%edi, %eax
               	addb	%al, %cs:(%rax)
               	pushfq
               	addb	%al, %cs:(%rax)
               	movabsl	-0x54ffffd159ffffd2, %eax
               	addb	%al, %cs:(%rax)
               	movb	$0x2e, %al
               	addb	%al, (%rax)
               	movb	$0x2e, %ch
               	addb	%al, (%rax)
               	movl	$0xbf00002e, %edx       # imm = 0xBF00002E
               	addb	%al, %cs:(%rax)
               	<unknown>
               	addb	%cl, %cl
               	addb	%al, %cs:(%rax)
               	<unknown>
               	addb	%al, %cs:(%rax)
               	shrl	%cl, (%rsi)
               	addb	%al, (%rax)
               	fsubrs	(%rsi)
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	loop	<addr>
               	addb	%al, (%rax)
               	outl	%eax, $0x2e
               	addb	%al, (%rax)
               	inb	%dx, %al
               	addb	%al, %cs:(%rax)
               	<unknown>
               	addb	%al, %cs:(%rax)
               	imulb	(%rsi)
               	addb	%al, (%rax)
               	sti
               	addb	%al, %cs:(%rax)
               	addb	%ch, (%rdi)
               	addb	%al, (%rax)
               	addl	$0xa00002f, %eax        # imm = 0xA00002F
               	<unknown>
               	addb	%al, (%rax)
               	comiss	(%rax), %xmm0
               	addb	%dl, (%rdi,%rbp)
               	addb	%al, (%rax)
               	sbbl	%ebp, (%rdi)
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	andl	(%rdi), %ebp
               	addb	%al, (%rax)
               	subb	%ch, (%rdi)
               	addb	%al, (%rax)
               	subl	$0x3200002f, %eax       # imm = 0x3200002F
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	cmpb	$0x2f, %al
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	pushq	%rax
               	<unknown>
               	addb	%al, (%rax)
               	pushq	%rbp
               	<unknown>
               	addb	%al, (%rax)
               	popq	%rdx
               	<unknown>
               	addb	%al, (%rax)
               	popq	%rdi
               	<unknown>
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	imull	$0x2f6e0000, (%rdi), %ebp # imm = 0x2F6E0000
               	addb	%al, (%rax)
               	jae	<addr>
               	addb	%al, (%rax)
               	js	<addr>
               	addb	%al, (%rax)
               	jge	<addr>
               	addb	%al, (%rax)
               	<unknown>
               	<unknown>
               	addb	%al, (%rax)
               	xchgl	%ebp, (%rdi)
               	addb	%al, (%rax)
               	movw	%gs, (%rdi)
               	addb	%al, (%rax)
               	xchgl	%ecx, %eax
               	<unknown>
               	addb	%al, (%rax)
               	xchgl	%esi, %eax
               	<unknown>
               	addb	%al, (%rax)
               	wait
               	<unknown>
               	addb	%al, (%rax)
               	movabsb	-0x55ffffd05affffd1, %al
               	<unknown>
               	addb	%al, (%rax)
               	scasl	%es:(%rdi), %eax
               	<unknown>
               	addb	%al, (%rax)
               	movb	$0x2f, %ah
               	addb	%al, (%rax)
               	movl	$0xbe00002f, %ecx       # imm = 0xBE00002F
               	<unknown>
               	addb	%al, (%rax)
               	retq
               	<unknown>
               	addb	%al, (%rax)
               	enter	$0x2f, $0x0
               	int	$0x2f
               	addb	%al, (%rax)
               	shrb	%cl, (%rdi)
               	addb	%al, (%rax)
               	xlatb
               	<unknown>
               	addb	%al, (%rax)
               	fsubrl	(%rdi)
               	addb	%al, (%rax)
               	loope	<addr>
               	addb	%al, (%rax)
               	outb	%al, $0x2f
               	addb	%al, (%rax)
               	jmp	<addr>
               	addb	%al, (%rax)
               	lock
               	<unknown>
               	addb	%al, (%rax)
               	cmc
               	<unknown>
               	addb	%al, (%rax)
               	cli
               	<unknown>
               	addb	%al, (%rax)
               	ljmpl	*(%rdi)
               	addb	%al, (%rax)
               	addb	$0x30, %al
               	addb	%al, (%rax)
               	orl	%esi, (%rax)
               	addb	%al, (%rax)
               	<unknown>
               	xorb	%al, (%rax)
               	addb	%dl, (%rbx)
               	xorb	%al, (%rax)
               	addb	%bl, (%rax)
               	xorb	%al, (%rax)
               	addb	%bl, <rip>
               	xorb	%al, (%rax)
               	addb	%ah, (%rdi)
               	xorb	%al, (%rax)
               	addb	%ch, (%rax,%rsi)
               	addb	%al, (%rax)
               	xorl	%esi, (%rax)
               	addb	%al, (%rax)
               	xorb	%al, %ss:(%rax)
               	addb	%bh, (%rbx)
               	xorb	%al, (%rax)
               	addb	%al, 0x30(%rax)
               	addb	%al, (%rax)
               	xorb	%r8b, (%r8)
               	addb	%cl, 0x30(%rdx)
               	addb	%al, (%rax)
               	xorb	%r8b, (%r8)
               	addb	%dl, (%rax,%rsi)
               	addb	%bl, 0x30(%rcx)
               	addb	%al, (%rax)
               	popq	%rsi
               	xorb	%al, (%rax)
               	addb	%ah, 0x30(%rbx)
               	addb	%al, (%rax)
               	pushq	$0x6d000030             # imm = 0x6D000030
               	xorb	%al, (%rax)
               	addb	%dh, 0x30(%rdx)
               	addb	%al, (%rax)
               	ja	<addr>
               	addb	%al, (%rax)
               	jl	<addr>
               	addb	%al, (%rax)
               	xorl	$0x30860000, (%rax)     # imm = 0x30860000
               	addb	%al, (%rax)
               	movl	(%rax), %esi
               	addb	%al, (%rax)
               	nop
               	xorb	%al, (%rax)
               	addb	%dl, -0x65ffffd0(%rbp)
               	xorb	%al, (%rax)
               	addb	%bl, -0x5bffffd0(%rdi)
               	xorb	%al, (%rax)
               	addb	%ch, -0x51ffffd0(%rcx)
               	xorb	%al, (%rax)
               	addb	%dh, -0x47ffffd0(%rbx)
               	xorb	%al, (%rax)
               	addb	%bh, -0x3dffffd0(%rbp)
               	xorb	%al, (%rax)
               	addb	%al, %bh
               	xorb	%al, (%rax)
               	addb	%cl, %ah
               	xorb	%al, (%rax)
               	addb	%dl, %cl
               	xorb	%al, (%rax)
               	addb	%dl, %dh
               	xorb	%al, (%rax)
               	addb	%bl, %bl
               	xorb	%al, (%rax)
               	addb	%ah, %al
               	xorb	%al, (%rax)
               	addb	%ah, %ch
               	xorb	%al, (%rax)
               	addb	%ch, %dl
               	xorb	%al, (%rax)
               	addb	%ch, %bh
               	xorb	%al, (%rax)
               	addb	%dh, %ah
               	xorb	%al, (%rax)
               	addb	%bh, %cl
               	xorb	%al, (%rax)
               	addb	%bh, %dh
               	xorb	%al, (%rax)
               	addb	%al, (%rbx)
               	xorl	%eax, (%rax)
               	addb	%cl, (%rax)
               	xorl	%eax, (%rax)
               	addb	%cl, <rip>
               	xorl	%eax, (%rax)
               	addb	%dl, (%rdi)
               	xorl	%eax, (%rax)
               	addb	%bl, (%rcx,%rsi)
               	addb	%al, (%rax)
               	andl	%esi, (%rcx)
               	addb	%al, (%rax)
               	xorl	%eax, %es:(%rax)
               	addb	%ch, (%rbx)
               	xorl	%eax, (%rax)
               	addb	%dh, (%rax)
               	xorl	%eax, (%rax)
               	addb	%dh, <rip>
               	xorl	%eax, (%rax)
               	addb	%bh, (%rdi)
               	xorl	%eax, (%rax)
               	addb	%al, (%rcx,%rsi)
               	addb	%cl, 0x31(%rcx)
               	addb	%al, (%rax)
               	xorq	%r8, (%rax)
               	addb	%dl, 0x31(%rbx)
               	addb	%al, (%rax)
               	popq	%rax
               	xorl	%eax, (%rax)
               	addb	%bl, 0x31(%rbp)
               	addb	%al, (%rax)
               	<unknown>
               	xorl	%eax, (%rax)
               	addb	%ch, (%rcx,%rsi)
               	addb	%dh, 0x31(%rcx)
               	addb	%al, (%rax)
               	jbe	<addr>
               	addb	%al, (%rax)
               	jnp	<addr>
               	addb	%al, (%rax)
               	xorb	$0x0, (%rcx)
               	addb	%al, -0x75ffffcf(%rbp)
               	xorl	%eax, (%rax)
               	addb	%cl, -0x6bffffcf(%rdi)
               	xorl	%eax, (%rax)
               	addb	%bl, -0x61ffffcf(%rcx)
               	xorl	%eax, (%rax)
               	addb	%ah, -0x57ffffcf(%rbx)
               	xorl	%eax, (%rax)
               	addb	%ch, -0x4dffffcf(%rbp)
               	xorl	%eax, (%rax)
               	addb	%dh, -0x43ffffcf(%rdi)
               	xorl	%eax, (%rax)
               	addb	%al, %cl
               	xorl	%eax, (%rax)
               	addb	%al, %dh
               	xorl	%eax, (%rax)
               	addb	%cl, %bl
               	xorl	%eax, (%rax)
               	addb	%dl, %al
               	xorl	%eax, (%rax)
               	addb	%dl, %ch
               	xorl	%eax, (%rax)
               	addb	%bl, %dl
               	xorl	%eax, (%rax)
               	addb	%bl, %bh
               	xorl	%eax, (%rax)
               	addb	%ah, %ah
               	xorl	%eax, (%rax)
               	addb	%ch, %cl
               	xorl	%eax, (%rax)
               	addb	%ch, %dh
               	xorl	%eax, (%rax)
               	addb	%dh, %bl
               	xorl	%eax, (%rax)
               	addb	%bh, %al
               	xorl	%eax, (%rax)
               	addb	%bh, %ch
               	xorl	%eax, (%rax)
               	addb	%al, (%rdx)
               	xorb	(%rax), %al
               	addb	%al, (%rdi)
               	xorb	(%rax), %al
               	addb	%cl, (%rdx,%rsi)
               	addb	%al, (%rax)
               	adcl	%esi, (%rdx)
               	addb	%al, (%rax)
               	<unknown>
               	xorb	(%rax), %al
               	addb	%bl, (%rbx)
               	xorb	(%rax), %al
               	addb	%ah, (%rax)
               	xorb	(%rax), %al
               	addb	%ah, <rip>
               	xorb	(%rax), %al
               	addb	%ch, (%rdi)
               	xorb	(%rax), %al
               	addb	%dh, (%rdx,%rsi)
               	addb	%al, (%rax)
               	cmpl	%esi, (%rdx)
               	addb	%al, (%rax)
               	xorb	%ds:(%rax), %al
               	addb	%al, 0x32(%rbx)
               	addb	%al, (%rax)
               	xorb	(%rax), %al
               	addb	%cl, 0x32(%rbp)
               	addb	%al, (%rax)
               	pushq	%rdx
               	xorb	(%rax), %al
               	addb	%dl, 0x32(%rdi)
               	addb	%al, (%rax)
               	popq	%rsp
               	xorb	(%rax), %al
               	addb	%ah, 0x32(%rcx)
               	addb	%al, (%rax)
               	xorb	(%rax), %al
               	addb	%ch, 0x32(%rbx)
               	addb	%al, (%rax)
               	jo	<addr>
               	addb	%al, (%rax)
               	jne	<addr>
               	addb	%al, (%rax)
               	jp	<addr>
               	addb	%al, (%rax)
               	jg	<addr>
               	addb	%al, (%rax)
               	testb	%dh, (%rdx)
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	movl	%esi, (%rdx)
               	addb	%al, (%rax)
               	<unknown>
               	addb	%bh, 0x1(%rax)
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x1ff, %edi            # imm = 0x1FF
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x3ff, %edi            # imm = 0x3FF
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x400, %edi            # imm = 0x400
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x7d0, %edi            # imm = 0x7D0
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
